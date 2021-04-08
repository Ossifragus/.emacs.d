(add-to-list 'load-path "~/Dropbox/mydoc/reinstallOS/Lisp/julia-emacs")
;; (add-to-list 'load-path "~/Dropbox/.Emacs/julia-repl")

;; julia-mode
(use-package julia-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.jl\\'" . julia-mode))
  (defun my-julia-hook ()
    ;; (auto-highlight-symbol-mode t)
    (highlight-indentation-mode t))
  (add-hook 'julia-mode-hook 'my-julia-hook)
)

(use-package julia-repl
  :ensure t
  :config
  (require 'julia-repl)
  (add-hook 'julia-mode-hook 'julia-repl-mode) ;; always use minor mode
  (set-language-environment "UTF-8")
  (julia-repl-set-terminal-backend 'vterm)
  (setq vterm-kill-buffer-on-exit nil)

  (defun julia-repl-send-line-nomove (); self defined
    (interactive)
    (julia-repl--send-string (thing-at-point 'line t) 'prefix t))
  (defun julia-repl-send-paragraph (); self defined
    "Send the current paragraph to the Julia REPL term buffer."
    (interactive)
    (let ((beg (save-excursion (backward-paragraph) (point)))
          (end (save-excursion (forward-paragraph) (point))))
      (julia-repl--send-string
       (buffer-substring-no-properties beg end)))
    (forward-paragraph))
  (defun julia-repl-send-function (); self defined
    "Send the current function to the Julia REPL term buffer."
    (interactive)
    (let ((beg (save-excursion (when (beginning-of-defun) (point))))
          (end (save-excursion (end-of-defun) (point))))
      (when (and beg (< beg end))
	(julia-repl--send-string
	 (buffer-substring-no-properties beg end)))))
  (defun my-julia-hook ()
    (local-set-key (kbd "C-c C-f") 'julia-repl-send-paragraph)
    (local-set-key (kbd "C-c C-j") 'julia-repl-send-line-nomove)
    (local-set-key (kbd "C-c C-r") 'julia-repl-send-region-or-line))
  (add-hook 'julia-mode-hook 'my-julia-hook)
  )

(setenv "JULIA_NUM_THREADS" "4")

(provide 'julia-config)

;; ;; This overwrite all the keys in the package
;; :bind (("C-c C-a" . julia-repl-activate-parent)
;; 	 ("C-c C-b" . julia-repl-send-buffer)
;; 	 ;; ("C-c C-c" . julia-repl-send-region-or-line)
;; 	 ("C-c C-c" . julia-repl-send-paragraph); self defined
;; 	 ("C-c C-j" . julia-repl-send-line-nomove); self defined
;; 	 ("C-c C-r" . julia-repl-send-region-or-line); self defined
;; 	 ("C-c C-d" . julia-repl-doc)
;; 	 ("C-c C-e" . julia-repl-edit)
;; 	 ("C-c C-l" . julia-repl-list-methods)
;; 	 ("C-c C-m" . julia-repl-macroexpand)
;; 	 ("C-c C-p" . julia-repl-cd)
;; 	 ("C-c C-s" . julia-repl-prompt-set-inferior-buffer-name-suffix)
;; 	 ("C-c C-t" . julia-repl-includet-buffer)
;; 	 ("C-c C-v" . julia-repl-prompt-set-executable-key)
;; 	 ("C-c C-z" . julia-repl)
;; 	 ("<C-return>" . julia-repl-send-line))

;; (use-package julia-snail
;;   :ensure t
;;   :requires vterm
;;   :hook (julia-mode . julia-snail-mode)
;;   )

;; (local-set-key (kbd "C-c C-f") 'julia-repl-send-paragraph)
;; (local-set-key (kbd "C-c C-j") 'julia-repl-send-line-nomove)
;; (local-set-key (kbd "C-c C-r") 'julia-repl-send-region-or-line)
