(use-package openwith
  :ensure t
  :config
  (require 'openwith)
  (setq openwith-associations '(("\\.pdf\\'" "evince" (file))))
  (setq openwith-associations '(("\\.odt\\'" "libreoffice" (file))))
  (setq openwith-associations '(("\\.doc\\'" "libreoffice" (file))))
  (setq openwith-associations '(("\\.docx\\'" "libreoffice" (file))))
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

