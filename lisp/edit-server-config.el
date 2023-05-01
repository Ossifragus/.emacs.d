;; (require 'edit-server)
;; (edit-server-start)
(when (locate-library "edit-server")
  (require 'edit-server)
  ;; (setq edit-server-new-frame nil)
  (edit-server-start))

(autoload 'edit-server-maybe-dehtmlize-buffer "edit-server-htmlize" "edit-server-htmlize" t)
(autoload 'edit-server-maybe-htmlize-buffer   "edit-server-htmlize" "edit-server-htmlize" t)
(add-hook 'edit-server-start-hook 'edit-server-maybe-dehtmlize-buffer)
;; (add-hook 'edit-server-start-hook 'LaTeX-mode)
(add-hook 'edit-server-start-hook 'org-mode)
(add-hook 'edit-server-done-hook  'edit-server-maybe-htmlize-buffer)

(require 'atomic-chrome)
(atomic-chrome-start-server)
(setq atomic-chrome-default-major-mode 'org-mode)
(setq atomic-chrome-buffer-open-style 'frame)
(setq atomic-chrome-url-major-mode-alist
      '(("github\\.com" . gfm-mode)
        ("localhost:8888" . python-mode)
        ;; ("redmine" . textile-mode)
        ))

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

(provide 'edit-server-config)
