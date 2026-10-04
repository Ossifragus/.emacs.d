;;; edit-server-config.el -*- lexical-binding: t; -*-

;; Functions for email/web-form formatting
(defun ES-htmlize (beg end)
  "Wrap selected region in <pre> tags with signature."
  (interactive "r")
  (save-excursion
    (narrow-to-region beg end)
    (goto-char (point-min))
    (insert "<pre>\n")
    (goto-char (point-max))
    (insert "\nBest regards,\nHaiYing</pre>")
    (widen)))

(defun ES-init ()
  "Insert template with <pre> tag and signature."
  (interactive)
  (goto-char (point-min))
  (insert "<pre>\n\nBest regards,\nHaiYing</pre>")
  (forward-line -2))

(use-package atomic-chrome
  :ensure t
  :demand t
  :bind (:map atomic-chrome-edit-mode-map
         ("C-c i" . ES-init)
         ("C-c h" . ES-htmlize))
  :config
  (evil-set-initial-state 'atomic-chrome-edit-mode 'normal)
  (setq atomic-chrome-default-major-mode 'org-mode)
  (setq atomic-chrome-buffer-open-style 'frame)
  (setq atomic-chrome-select-frame 'current)
  (setq ghost-text-display-buffer-function 'switch-to-buffer)
  (setq atomic-chrome-url-major-mode-alist
        '(("github\\.com" . gfm-mode)
          ("localhost:8888" . python-mode)))
  (atomic-chrome-start-server))

(use-package emacs-everywhere
  :ensure t
  :bind (:map emacs-everywhere-mode-map
         ("C-c i" . ES-init)
         ("C-c h" . ES-htmlize)))

(use-package overleaf
  ;; https://github.com/vale981/overleaf.el
  ;; https://github.com/mozilla/geckodriver
  :ensure t
  :custom
  (overleaf-use-nerdfont t "Use nerdfont icons for the modeline.")
  :config
  (setq overleaf-cookies
        (overleaf-read-cookies-from-firefox
         :firefox-folder "~/snap/firefox/common/.mozilla/firefox/"
         :profile "default")))

(provide 'edit-server-config)
;;; edit-server-config.el ends here
