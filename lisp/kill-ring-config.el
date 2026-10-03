;;; kill-ring-config.el -*- lexical-binding: t; -*-

(use-package browse-kill-ring
  :ensure t
  :bind (("C-c y" . browse-kill-ring)
         :map browse-kill-ring-mode-map
         ("j" . browse-kill-ring-forward)
         ("k" . browse-kill-ring-previous))
  :config
  (with-eval-after-load 'evil
    ;; Global leader binding for quick access
    (evil-define-key 'normal 'global
      (kbd "<leader>y") #'browse-kill-ring)))

(provide 'kill-ring-config)
;;; kill-ring-config.el ends here
