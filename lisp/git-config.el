;;; git-config.el -*- lexical-binding: t; -*-

(use-package magit
  :ensure t
  :bind (("C-x g"   . magit-status)
         ("C-x M-g" . magit-dispatch))
  :config
  (setq-default magit-diff-refine-hunk 'all))

(use-package forge
  :ensure t
  :after magit
  :init
  ;; Prevent Forge from installing default transient/key bindings that clash
  ;; with modern Magit transients and evil-collection.
  (setq forge-add-default-bindings nil))

(use-package diff-hl
  :ensure t
  :hook ((magit-post-refresh . diff-hl-magit-post-refresh)
         (magit-pre-refresh  . diff-hl-magit-pre-refresh))
  :init
  (global-diff-hl-mode 1)
  :config
  (diff-hl-flydiff-mode 1))
  
(provide 'git-config)
;;; git-config.el ends here
