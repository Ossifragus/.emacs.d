;; ;; (require 'edit-server)
;; ;; (edit-server-start)
;; (use-package edit-server-htmlize
;;   :ensure t
;;   )
;; (when (locate-library "edit-server")
;;   (require 'edit-server)
;;   ;; (setq edit-server-new-frame nil)
;;   (edit-server-start))

;; (autoload 'edit-server-maybe-dehtmlize-buffer "edit-server-htmlize" "edit-server-htmlize" t)
;; (autoload 'edit-server-maybe-htmlize-buffer   "edit-server-htmlize" "edit-server-htmlize" t)
;; (add-hook 'edit-server-start-hook 'edit-server-maybe-dehtmlize-buffer)
;; ;; (add-hook 'edit-server-start-hook 'LaTeX-mode)
;; (add-hook 'edit-server-start-hook 'org-mode)
;; (add-hook 'edit-server-done-hook  'edit-server-maybe-htmlize-buffer)

(use-package atomic-chrome
  :ensure t
  :config
  (setq atomic-chrome-default-major-mode 'org-mode)
  (setq atomic-chrome-buffer-open-style 'frame)
  (setq atomic-chrome-url-major-mode-alist
        '(("github\\.com" . gfm-mode)
          ("localhost:8888" . python-mode)
          ;; ("redmine" . textile-mode)
          )))
(atomic-chrome-start-server)

;; https://emacs.stackexchange.com/questions/69133/how-to-write-an-elisp-function-to-insert-some-text-at-the-beginning-and-end-of-a
(defun ES-htmlize (beg end)
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
  (interactive)
    (goto-char (point-min))
    (insert "<pre>\n\nBest regards,\nHaiYing\n</pre>")
    (previous-line 3))

(global-set-key ( kbd "C-c i") 'ES-init)
(global-set-key ( kbd "C-c h") 'ES-htmlize)

(use-package emacs-everywhere
  :ensure t)

(use-package overleaf
  ;; https://github.com/vale981/overleaf.el
  ;; https://github.com/mozilla/geckodriver
  :ensure t
  :custom
  (overleaf-use-nerdfont t "Use nerfont icons for the modeline.")
  :config
  ;; Example: load/save cookies from GPG encrypted file.
  ;;          (remove the .gpg extension to save unencrypted)
  ;; (let ((cookie-file "~/.overleaf-cookies.gpg"))
  (let ((cookie-file "~/.overleaf-cookies"))
    (setq overleaf-save-cookies
          (overleaf-save-cookies-to-file cookie-file))
    (setq overleaf-cookies
          (overleaf-read-cookies-from-file cookie-file)))
  )

(provide 'edit-server-config)
