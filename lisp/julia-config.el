(add-to-list 'load-path "~/Dropbox/.Emacs/julia-emacs")
(add-to-list 'load-path "~/Dropbox/.Emacs/julia-repl")

;; julia-mode
(use-package julia-mode
  :ensure t
  :config
  ;; (add-to-list 'auto-mode-alist '("\\.jl\\'" . julia-mode))
)

(use-package julia-repl
  :ensure t
  :config
  (require 'julia-repl)
  (add-hook 'julia-mode-hook 'julia-repl-mode) ;; always use minor mode
  (set-language-environment "UTF-8")
  (julia-repl-set-terminal-backend 'vterm)
  (setq vterm-kill-buffer-on-exit nil)
  )

;; (use-package julia-snail
;;   :ensure t
;;   :requires vterm
;;   :hook (julia-mode . julia-snail-mode)
;;   )

(defun my-julia-hook ()
  (highlight-indentation-mode t)
  ;; (auto-highlight-symbol-mode t)
  (julia-repl-mode t)
  )
(add-hook 'julia-mode-hook 'my-julia-hook)
(setenv "JULIA_NUM_THREADS" "4")


(provide 'julia-config)
