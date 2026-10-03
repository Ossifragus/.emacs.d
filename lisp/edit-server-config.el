;;; edit-server-config.el -*- lexical-binding: t; -*-

;; Functions for email/web-form formatting
(defun ES-htmlize (beg end)
  "Wrap selected region in <pre> tags with signature."
  (interactive "r")
  (save-excursion
    (narrow-to-region beg end)
    (set-mark nil)
    (goto-char (point-min))
    (insert "<pre>")
    (goto-char (point-max))
    (insert "\nBest regards,\nHaiYing\n</pre>")
    (widen)))

(defun ES-init ()
  "Insert template with <pre> tag and signature."
  (interactive)
  (goto-char (point-min))
  (insert "<pre>\n\nBest regards,\nHaiYing\n</pre>")
  (forward-line -2))

(defun my/atomic-chrome-email-setup ()
  "Auto-insert email template when opening an empty browser edit buffer."
  (when (and (derived-mode-p 'org-mode)
             (= (buffer-size) 0))
    (ES-init)))

(use-package atomic-chrome
  :ensure t
  :bind (:map atomic-chrome-edit-mode-map
         ("C-c i" . ES-init)
         ("C-c h" . ES-htmlize))
  :hook (atomic-chrome-edit-mode . my/atomic-chrome-email-setup)
  :config
  (with-eval-after-load 'evil-collection
    (evil-set-initial-state 'atomic-chrome-edit-mode 'normal))
  (setq atomic-chrome-default-major-mode 'org-mode)
  (setq atomic-chrome-buffer-open-style 'frame)
  (setq atomic-chrome-url-major-mode-alist
        '(("github\\.com" . gfm-mode)
          ("localhost:8888" . python-mode)))
  (atomic-chrome-start-server))

(use-package emacs-everywhere
  :ensure t)

(provide 'edit-server-config)
;;; edit-server-config.el ends here
