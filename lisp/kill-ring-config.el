(use-package browse-kill-ring
  :ensure t
  :config
  (global-set-key "\C-cy" 'browse-kill-ring)
  )

;; (use-package kill-ring-search
;;   :ensure t
;;   :config
;;   (global-set-key "\M-\C-y" 'kill-ring-search)
;;   )

(provide 'kill-ring-config)

