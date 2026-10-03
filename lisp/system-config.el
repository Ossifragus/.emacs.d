;;; system-config.el -*- lexical-binding: t; -*-

(use-package exec-path-from-shell
  :ensure t
  :if (or (daemonp) (display-graphic-p))
  :config
  (exec-path-from-shell-initialize))

;; Modern replacement for openwith: dired-open
(use-package dired-open
  :ensure t
  :config
  (setq dired-open-extensions
        '(("pdf"   . "papers")
          ("ps"    . "papers")
          ("djvu"  . "papers")
          ("jpg"   . "loupe")
          ("jpeg"  . "loupe")
          ("png"   . "loupe")
          ("webp"  . "loupe")
          ("gif"   . "loupe")
          ("dot"   . "xdot")
          ("m4v"   . "smplayer")
          ("mp4"   . "smplayer")
          ("mts"   . "smplayer")
          ("mpg"   . "smplayer")
          ("mov"   . "smplayer")
          ("avi"   . "smplayer")
          ("flv"   . "smplayer")
          ("mkv"   . "smplayer")
          ("webm"  . "smplayer")
          ("xls"   . "libreoffice")
          ("xlsx"  . "libreoffice")
          ("doc"   . "libreoffice")
          ("docx"  . "libreoffice")
          ("odt"   . "libreoffice")
          ("ppt"   . "libreoffice")
          ("pptx"  . "libreoffice")
          ("odp"   . "libreoffice")))

  ;; Intercept find-file commands before Emacs parses binary/media files into a buffer
  (defun my/find-file-open-externally-advice (orig-fn filename &rest args)
    "Open FILENAME with external application if in `dired-open-extensions`."
    (let* ((ext (and (stringp filename)
                     (file-name-extension filename)
                     (downcase (file-name-extension filename))))
           (app (and ext (cdr (assoc ext dired-open-extensions)))))
      (if (and app (file-exists-p filename) (not (file-directory-p filename)))
          (progn
            (start-process-shell-command app nil (format "%s %s" app (shell-quote-argument (expand-file-name filename))))
            (message "Opened %s with %s" (file-name-nondirectory filename) app)
            nil)
        (apply orig-fn filename args))))

  (advice-add 'find-file :around #'my/find-file-open-externally-advice)
  (advice-add 'find-file-other-window :around #'my/find-file-open-externally-advice)
  (advice-add 'find-file-other-frame :around #'my/find-file-open-externally-advice))

(provide 'system-config)
;;; system-config.el ends here
