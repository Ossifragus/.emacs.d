;;; julia-config.el -*- lexical-binding: t; -*-

(use-package julia-mode
  :ensure t
  :mode ("\\.jl\\'" . julia-mode)
  :hook ((julia-mode . auto-highlight-symbol-mode)
         (julia-mode . display-line-numbers-mode)
         (julia-mode . highlight-indentation-mode)
         (julia-mode . highlight-numbers-mode)
         (julia-mode . julia-math-mode))
  :config
  (require 'julia-highlight)

  ;; Evil leader bindings in julia buffers
  (with-eval-after-load 'evil
    (evil-define-key '(normal visual) julia-mode-map
      (kbd "<leader>b") #'julia-repl-send-buffer
      (kbd "<leader>l") #'julia-repl-send-line
      (kbd "<leader>p") #'julia-repl-send-paragraph
      (kbd "<leader>f") #'julia-repl-send-function
      (kbd "<leader>j") #'julia-repl-send-line-nomove
      (kbd "<leader>n") #'julia-repl-prompt-switches
      (kbd "<leader>r") #'julia-repl-send-region-or-line)))

(define-globalized-minor-mode global-math-mode julia-math-mode
  (lambda ()
    (unless (eq major-mode 'LaTeX-mode)
      (julia-math-mode 1))))
(global-math-mode 1)

(use-package julia-repl
  :ensure t
  :hook (julia-mode . julia-repl-mode)
  :bind (:map julia-mode-map
         ("C-c p"   . julia-repl-send-paragraph)
         ("C-c C-f" . julia-repl-send-function)
         ("C-c C-j" . julia-repl-send-line-nomove)
         ("C-c C-n" . julia-repl-prompt-switches)
         ("C-c C-r" . julia-repl-send-region-or-line))
  :config
  (set-language-environment "UTF-8")
  (julia-repl-set-terminal-backend 'vterm)
  (setq julia-repl-executable-records
        '((default "julia")
          (lts     "julia +lts")
          (rc      "julia +rc")
          (beta    "julia +beta")))
  (setq vterm-kill-buffer-on-exit nil)
  (setq julia-repl-skip-comments t)

  (defun julia-repl-send-line-nomove ()
    "Send current line without moving point."
    (interactive)
    (julia-repl--send-string (thing-at-point 'line t) 'prefix t))

  (defun julia-repl-send-paragraph ()
    "Send the current paragraph to the Julia REPL term buffer."
    (interactive)
    (let ((beg (save-excursion (backward-paragraph) (point)))
          (end (save-excursion (forward-paragraph) (point))))
      (julia-repl--send-string (buffer-substring-no-properties beg end)))
    (forward-paragraph))

  (defun julia-repl-send-function ()
    "Send the current function to the Julia REPL term buffer."
    (interactive)
    (let ((beg (save-excursion (when (beginning-of-defun) (point))))
          (end (save-excursion (end-of-defun) (point))))
      (when (and beg (< beg end))
        (julia-repl--send-string (buffer-substring-no-properties beg end))))))

(setenv "JULIA_EDITOR" "emacsclient")

(use-package eglot-jl
  :ensure t
  :demand t
  :config
  (eglot-jl-init)
  ;; LanguageServer 5.1+ uses JuliaWorkspaces and starts via `runserver'.
  ;; This avoids the legacy SymbolServer entry point, which is incompatible
  ;; with Julia 1.13.
  (defun my-eglot-jl--ls-invocation (&rest _ignored)
    "Start the Julia language server for the current buffer."
    `(,eglot-jl-julia-command
      "--startup-file=no"
      ,(concat "--project=" eglot-jl-language-server-project)
      "-e" "using LanguageServer; runserver()"
      ,(file-name-directory (buffer-file-name))))
  (advice-add 'eglot-jl--ls-invocation :override
              #'my-eglot-jl--ls-invocation)
  (setq eglot-connect-timeout 300))

(require 'julia-poly)

(provide 'julia-config)
;;; julia-config.el ends here
