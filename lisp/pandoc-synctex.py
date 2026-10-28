#!/usr/bin/env python3
"""Pandoc wrapper that generates Markdown-mapped SyncTeX (.synctex.gz) for PDF output."""

import difflib
import gzip
import os
import re
import shutil
import stat
import subprocess
import sys
import tempfile


def tokenize_line(line: str) -> list[str]:
    return re.findall(r"\\[a-zA-Z]+|[a-zA-Z0-9]+", line.lower())


def build_tex_to_md_map(md_text: str, tex_text: str) -> dict[int, int]:
    md_lines = md_text.splitlines()
    tex_lines = tex_text.splitlines()

    md_toks = [tokenize_line(l) for l in md_lines]
    tex_toks = [tokenize_line(l) for l in tex_lines]

    begin_doc = 0
    for i, line in enumerate(tex_lines):
        if "\\begin{document}" in line:
            begin_doc = i
            break

    md_flat = [(tok, i) for i, toks in enumerate(md_toks, 1) for tok in toks]
    tex_flat = [
        (tok, i + 1)
        for i in range(begin_doc, len(tex_toks))
        for tok in tex_toks[i]
    ]

    sm = difflib.SequenceMatcher(
        None,
        [x[0] for x in tex_flat],
        [x[0] for x in md_flat],
        autojunk=False,
    )

    tex_to_md: dict[int, int] = {}
    for ti, mi, size in sm.get_matching_blocks():
        for k in range(size):
            t_line = tex_flat[ti + k][1]
            m_line = md_flat[mi + k][1]
            if t_line not in tex_to_md:
                tex_to_md[t_line] = m_line

    last = 1
    for i in range(1, len(tex_lines) + 1):
        if i in tex_to_md:
            last = tex_to_md[i]
        else:
            tex_to_md[i] = last

    return tex_to_md


def fix_synctex_byte_offsets(raw_text: str) -> str:
    lines = raw_text.splitlines(True)
    out = []
    acc = 0
    prev_bang_len = 0
    for line in lines:
        if line.startswith("!"):
            newline = "\n" if line.endswith("\n") else ""
            total = prev_bang_len + acc
            new_bang = f"!{total}{newline}"
            out.append(new_bang)
            prev_bang_len = len(new_bang.encode("latin1"))
            acc = 0
        else:
            out.append(line)
            acc += len(line.encode("latin1"))
    return "".join(out)


def rewrite_synctex(
    synctex_in: str,
    synctex_out: str,
    tex_filename: str,
    md_path: str,
    tex_to_md: dict[int, int],
) -> None:
    with gzip.open(synctex_in, "rb") as f:
        raw = f.read().decode("latin1")

    input_tag = "1"

    def repl_input(match: re.Match) -> str:
        nonlocal input_tag
        input_tag = match.group(1)
        return f"Input:{input_tag}:{md_path}"

    raw = re.sub(
        r"^Input:(\d+):.*" + re.escape(tex_filename) + r"$",
        repl_input,
        raw,
        count=1,
        flags=re.M,
    )

    record_pat = re.compile(
        r"^([(\[hvkgx$f])(" + re.escape(input_tag) + r"),(\d+)(:.*)$",
        re.M,
    )

    def repl_line(match: re.Match) -> str:
        t_line = int(match.group(3))
        m_line = tex_to_md.get(t_line, 1)
        return f"{match.group(1)}{match.group(2)},{m_line}{match.group(4)}"

    raw = record_pat.sub(repl_line, raw)
    raw = fix_synctex_byte_offsets(raw)

    with gzip.open(synctex_out, "wb") as f:
        f.write(raw.encode("latin1"))


def find_real_binary(name: str, exclude_dir: str) -> str:
    if os.path.isabs(name) and os.access(name, os.X_OK):
        return name
    path_dirs = [
        p
        for p in os.environ.get("PATH", "").split(os.pathsep)
        if os.path.abspath(p) != os.path.abspath(exclude_dir)
    ]
    found = shutil.which(name, path=os.pathsep.join(path_dirs))
    return found or name


def main() -> int:
    args = sys.argv[1:]
    pdf_output = None
    engine_spec = "xelatex"
    new_args = []

    i = 0
    while i < len(args):
        arg = args[i]
        if arg.startswith("--output="):
            out_val = arg.split("=", 1)[1]
            if out_val.lower().endswith(".pdf"):
                pdf_output = os.path.abspath(os.path.expanduser(out_val))
                arg = f"--output={pdf_output}"
            new_args.append(arg)
        elif arg == "-o" and i + 1 < len(args):
            out_val = args[i + 1]
            if out_val.lower().endswith(".pdf"):
                pdf_output = os.path.abspath(os.path.expanduser(out_val))
                new_args.extend(["-o", pdf_output])
            else:
                new_args.extend([arg, out_val])
            i += 2
            continue
        elif arg.startswith("--pdf-engine="):
            engine_spec = arg.split("=", 1)[1]
        elif arg == "--pdf-engine" and i + 1 < len(args):
            engine_spec = args[i + 1]
            i += 2
            continue
        else:
            new_args.append(arg)
        i += 1

    if not pdf_output:
        os.execvp("pandoc", ["pandoc"] + args)

    engine_base = os.path.basename(engine_spec)
    latex_engines = {"xelatex", "lualatex", "pdflatex"}
    if engine_base not in latex_engines:
        os.execvp("pandoc", ["pandoc"] + args)

    md_bytes = sys.stdin.buffer.read()
    md_text = md_bytes.decode("utf-8", errors="replace")

    md_path = os.environ.get("PANDOC_SOURCE_FILE")
    if md_path:
        md_path = os.path.abspath(os.path.expanduser(md_path))
    else:
        candidate = os.path.splitext(pdf_output)[0] + ".md"
        md_path = candidate

    with tempfile.TemporaryDirectory(prefix="pandoc-synctex-") as wrap_dir:
        real_engine = find_real_binary(engine_spec, wrap_dir)
        saved_tex = os.path.join(wrap_dir, "saved_input.tex")
        saved_synctex = os.path.join(wrap_dir, "saved_input.synctex.gz")
        wrapper_path = os.path.join(wrap_dir, engine_base)

        wrapper_code = f"""#!/usr/bin/env python3
import os, shutil, subprocess, sys

args = sys.argv[1:]
tex_file = next((a for a in reversed(args) if a.endswith(".tex")), None)
cmd = [{real_engine!r}, "-synctex=1"] + args
res = subprocess.run(cmd)
if res.returncode == 0 and tex_file and os.path.exists(tex_file):
    shutil.copyfile(tex_file, {saved_tex!r})
    st = os.path.splitext(tex_file)[0] + ".synctex.gz"
    if os.path.exists(st):
        shutil.copyfile(st, {saved_synctex!r})
sys.exit(res.returncode)
"""
        with open(wrapper_path, "w", encoding="utf-8") as f:
            f.write(wrapper_code)
        os.chmod(wrapper_path, stat.S_IRWXU)

        pandoc_cmd = ["pandoc", f"--pdf-engine={wrapper_path}"] + new_args
        proc = subprocess.run(pandoc_cmd, input=md_bytes)
        if proc.returncode != 0:
            return proc.returncode

        if os.path.exists(saved_tex) and os.path.exists(saved_synctex):
            with open(saved_tex, "r", encoding="utf-8", errors="replace") as f:
                tex_text = f.read()
            tex_to_md = build_tex_to_md_map(md_text, tex_text)
            synctex_out = os.path.splitext(pdf_output)[0] + ".synctex.gz"
            rewrite_synctex(
                saved_synctex,
                synctex_out,
                "input.tex",
                md_path,
                tex_to_md,
            )

    return 0


if __name__ == "__main__":
    sys.exit(main())
