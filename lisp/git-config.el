(use-package magit
  :ensure t
  :config
  (setq-default magit-diff-refine-hunk 'all)
  (global-set-key (kbd "C-x g") 'magit-status)
  (add-hook 'magit-mode-hook 'visual-line-mode)
  ;; (global-set-key (kbd "C-x M-g") 'magit-dispatch)
  )
(use-package forge
  :ensure t
  :after magit
	)
(use-package diff-hl
  :ensure t
  :config
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'after-init-hook 'global-diff-hl-mode)
	)

(provide 'git-config)

;; (use-package magit-todos
;;   :ensure t
;;   :after (magit)
;;   :config
;;   (let ((inhibit-message t))
;;     (magit-todos-mode 1))
;;   (transient-append-suffix 'magit-status-jump '(0 0 -1)
;;     '("T " "Todos" magit-todos-jump-to-todos))
;;   (setq magit-todos-exclude-globs '("*.html" "*.json" "*.map" "*.js"))
;;   )
