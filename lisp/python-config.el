(use-package python
  :ensure nil
  :defer t
  :config
  (setq python-indent-guess-indent-offset-verbose nil))

(use-package eglot
  :ensure t
  :hook (python-mode . eglot-ensure))

(defun my-python-hook ()
  (display-line-numbers-mode t)
  (hs-minor-mode t)
  (highlight-numbers-mode t)
  (local-set-key (kbd "C-c C-c") 'python-shell-send-buffer)
  (local-set-key (kbd "C-c C-r") 'python-shell-send-region)
  (local-set-key (kbd "C-c C-l") 'python-shell-send-file))

(add-hook 'python-mode-hook 'my-python-hook)

(use-package conda
  :ensure t
  :config
  (require 'conda)
  )

(provide 'python-config)
