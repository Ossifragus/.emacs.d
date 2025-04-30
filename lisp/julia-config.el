;; (add-to-list 'load-path "~/Dropbox/mydoc/reinstallOS/Lisp/julia-emacs")
;; (add-to-list 'load-path "~/Dropbox/.Emacs/julia-repl")

;; julia-mode
(use-package julia-mode
  :ensure t
  :config
  (require 'julia-highlight)
  (add-to-list 'auto-mode-alist '("\\.jl\\'" . julia-mode))
  (defun my-julia-hook ()
    ;; (auto-highlight-symbol-mode t)
    (display-line-numbers-mode t)
    (highlight-indentation-mode t)
    (highlight-numbers-mode t))
  (add-hook 'julia-mode-hook 'my-julia-hook)
  (add-hook 'julia-mode-hook 'julia-math-mode)
  (add-hook 'julia-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map
                        (kbd "gl") 'julia-repl-send-line)
            ))
  )

(define-globalized-minor-mode global-math-mode julia-math-mode
  (lambda ()
    (unless (eq major-mode 'LaTeX-mode)
      (julia-math-mode))))
(global-math-mode 1)

(use-package julia-repl
  :ensure t
  :config
  (require 'julia-repl)
  (add-hook 'julia-mode-hook 'julia-repl-mode) ;; always use minor mode
	;; (add-hook 'julia-repl-hook #'julia-repl-use-emacsclient) ; JULIA_EDITOR @edit
  (set-language-environment "UTF-8")
  (julia-repl-set-terminal-backend 'vterm)
  ;; (auto ,(concat (expand-file-name "App/julia/bin/julia") " -t auto"))
  (setq julia-repl-executable-records
        `((default "julia") ; in the executable path
          (lts "julia +lts")
          (rc "julia +rc")
          (beta "julia +beta")
          ))
  (setq vterm-kill-buffer-on-exit nil)
	(setq julia-repl-skip-comments t)
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
  (defun my-julia-repl-hook ()
    (local-set-key (kbd "C-c C-f") 'julia-repl-send-paragraph)
    (local-set-key (kbd "C-c C-j") 'julia-repl-send-line-nomove)
    (local-set-key (kbd "C-c C-n") 'julia-repl-prompt-switches)
    (local-set-key (kbd "C-c C-r") 'julia-repl-send-region-or-line))
  (add-hook 'julia-mode-hook 'my-julia-repl-hook)
  )

;; (setenv "JULIA_NUM_THREADS" "10")
(setenv "JULIA_EDITOR" "emacsclient")
;; (setenv "LD_PRELOAD" "/usr/lib/x86_64-linux-gnu/libstdc++.so.6")

(use-package eglot-jl
  :ensure t
  :config
  (setq eglot-connect-timeout 300)
  )

(require 'poly-julia)

(provide 'julia-config)

;; ;; This overwrite all the keys in the package
;; :bind (("C-c C-a" . julia-repl-activate-parent)
;; 	 ;; ("C-c C-c" . julia-repl-send-region-or-line)
;; 	 ("C-c C-c" . julia-repl-send-paragraph); self defined
;; 	 ("C-c C-j" . julia-repl-send-line-nomove); self defined
;; 	 ("C-c C-r" . julia-repl-send-region-or-line); self defined
;; 	 ("C-c C-z" . julia-repl)
;; 	 ("<C-return>" . julia-repl-send-line))

;; (use-package julia-snail
;;   :ensure t
;;   :requires vterm
;;   :hook (julia-mode . julia-snail-mode)
;;   )
