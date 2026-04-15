(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))
  (when (daemonp)
    (exec-path-from-shell-initialize)))

;; Modern replacement for openwith: dired-open
;; This will automatically open these file types with the specified 
;; external programs when you press RET on them in Dired.
(use-package dired-open
  :ensure t
  :config
  (setq dired-open-extensions
        '(("pdf" . "evince")
          ("jpg" . "evince")
          ("m4v" . "smplayer")
          ("mp4" . "smplayer")
          ("MP4" . "smplayer")
          ("MTS" . "smplayer")
          ("mpg" . "smplayer")
          ("mov" . "smplayer")
          ("avi" . "smplayer")
          ("AVI" . "smplayer")
          ("flv" . "smplayer")
          ("xls" . "libreoffice --calc")
          ("xlsx" . "libreoffice --calc")
          ("doc" . "libreoffice --writer")
          ("docx" . "libreoffice --writer")
          ("odt" . "libreoffice --writer"))))

(provide 'system-config)
