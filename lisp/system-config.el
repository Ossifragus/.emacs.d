(use-package openwith
  :ensure t
  :config
  (require 'openwith)
  (setq openwith-associations '(("\\.pdf\\'" "evince" (file))))
  (openwith-mode t)
  )

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))
  (when (daemonp)
    (exec-path-from-shell-initialize))
  )

(provide 'system-config)

