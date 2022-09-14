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

(defun OL-htmlize ()
  "Do a simple HTMLification of the buffer as plain text.
This produces HTML intended to reproduce the original plain text contents
of the buffer."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (insert "<pre>")
    ;; (edit-server-htmlize-replace edit-server-htmlize-regexp
    ;;                              edit-server-htmlize-replacements)
    (goto-char (point-max))
    (insert "</pre>")))

(provide 'edit-server-config)
