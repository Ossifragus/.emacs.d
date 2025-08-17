(use-package openwith
  :ensure t
  :config
  (require 'openwith)
  (setq openwith-associations
        (list
         (list (openwith-make-extension-regexp
           '("pdf" "jpg"))
          "evince" '(file))
         (list (openwith-make-extension-regexp
                '("m4v" "mp4" "MP4" "MTS" "mpg" "mov" "avi" "AVI" "flv"))
               "smplayer" '(file))
         (list (openwith-make-extension-regexp
           '("xls" "xlsx"))
          "libreoffice --calc" '(file))
         (list (openwith-make-extension-regexp
           '("doc" "docx" "odt"))
               "libreoffice --writer" '(file))
         ))
  (openwith-mode t)
  )
;; (rassq-delete-all #'doc-view-mode-maybe auto-mode-alist)

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))
  (when (daemonp)
    (exec-path-from-shell-initialize))
  )

(provide 'system-config)

