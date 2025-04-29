(use-package treesit-auto
  :ensure t
  :config
  (global-treesit-auto-mode))

(setq treesit-language-source-alist
      '(
        ;; (bash "https://github.com/tree-sitter/tree-sitter-bash")
        ;; (css "https://github.com/tree-sitter/tree-sitter-css")
        ;; (go "https://github.com/tree-sitter/tree-sitter-go")
        ;; (html "https://github.com/tree-sitter/tree-sitter-html")
        ;; (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
        ;; (json "https://github.com/tree-sitter/tree-sitter-json")
        ;; (julia "https://github.com/tree-sitter/tree-sitter-julia")
        (markdown "https://github.com/tree-sitter-grammars/tree-sitter-markdown" "split_parser" "tree-sitter-markdown/src")
        (markdown-inline "https://github.com/tree-sitter-grammars/tree-sitter-markdown" "split_parser" "tree-sitter-markdown-inline/src")
        ;; (python "https://github.com/tree-sitter/tree-sitter-python")
        ;; (toml "https://github.com/tree-sitter/tree-sitter-toml")
        ;; (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        ;; (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        ))

(setq major-mode-remap-alist
      '(
        (markdown-mode . markdown-ts-mode)
        ;; (python-mode . python-ts-mode)
   ))

(use-package markdown-ts-mode
  :ensure t
  ;; :mode ("\\.md\\'" . markdown-ts-mode)
  ;; :defer 't
  ;; :config
  )

(use-package julia-ts-mode
  :ensure t
  ;; :mode "\\.jl$"
  )

(provide 'treesitter-config)

