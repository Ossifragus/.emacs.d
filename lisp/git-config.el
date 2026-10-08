;;; git-config.el -*- lexical-binding: t; -*-

(use-package magit
  :ensure t
  :bind (("C-x g"   . magit-status)
         ("C-x M-g" . magit-dispatch))
  :config
  (setq-default magit-diff-refine-hunk 'all)
  (define-advice magit-diff-visit-file--internal (:around (orig-fn force-worktree display) reuse-window)
    "When DISPLAY is nil, reuse a window already showing the target file if one exists."
    (if display
        (funcall orig-fn force-worktree display)
      (let ((display-buffer-overriding-action
             '((display-buffer-reuse-window display-buffer-same-window)
               (inhibit-same-window . nil)
               (reusable-frames . visible))))
        (funcall orig-fn force-worktree display)))))

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
