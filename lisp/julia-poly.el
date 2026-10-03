;;; julia-poly.el --- Polymode for Julia language -*- lexical-binding: t; -*-

(require 'polymode)
(use-package poly-markdown
  :ensure t)

(declare-function julia-repl-inferior-buffer "julia-repl")
(declare-function julia-repl--send-string "julia-repl")
(declare-function julia-repl "julia-repl")

;;; Polymode Definitions

(define-innermode poly-julia-markdown-inline-code-innermode poly-markdown-inline-code-innermode
  :mode 'julia-mode
  :head-matcher (cons "^[ \t]*\\(```{?[Jj]ulia.*\\n\\)" 1)
  :tail-matcher (cons "^[ \t]*\\(```\\)[ \t]*$" 1)
  :head-mode 'host
  :tail-mode 'host)

(define-polymode poly-markdown+julia-mode poly-markdown-mode
  :lighter " PM-jmd"
  :innermodes '(poly-julia-markdown-inline-code-innermode))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.[jJ]md\\'" . poly-markdown+julia-mode))

;; Keybindings for poly-markdown+julia-mode
(let ((map poly-markdown+julia-mode-map))
  (define-key map (kbd "C-c o")   #'julia-repl)
  (define-key map (kbd "C-c C-z") #'julia-repl)
  (define-key map (kbd "C-c w")   #'jmarkdown-weave-to-markdown)
  (define-key map (kbd "C-l")     #'recenter-top-bottom))

;;; Weave.jl Integration

(defun poly-julia-run-command (command _callback &rest _ignore)
  (let ((inferior-buffer (julia-repl-inferior-buffer)))
    (display-buffer inferior-buffer)
    (julia-repl--send-string command)))

(defun poly-julia-callback (_proc _string))

(defvar poly-julia-weavejl-weavers
  (pm-callback-weaver :name "JMarkdown"
                      :from-to
                      '(("markdown" "\\.j?md\\'" "md" "Markdown"
                         "using Weave; weave(\"%I\", mod=Main, doctype=\"multimarkdown\", fig_path=\"pdf/%i/\", fig_ext=\".pdf\", cache=:on)"))
                      :function #'poly-julia-run-command
                      :callback #'poly-julia-callback))

(polymode-register-weaver poly-julia-weavejl-weavers nil
                          poly-markdown-polymode)

(defun jmarkdown-weave-to-markdown ()
  "Weave the current buffer to markdown via Weave.jl."
  (interactive)
  (oset pm/polymode :weaver 'poly-julia-weavejl-weavers)
  (save-excursion
    (polymode-weave "markdown")))

(provide 'julia-poly)
;;; julia-poly.el ends here
