;;; python-config.el -*- lexical-binding: t; -*-

(use-package python
  :ensure nil
  :defer t
  :bind (:map python-mode-map
         ("C-c C-c" . python-shell-send-buffer)
         ("C-c C-r" . python-shell-send-region)
         ("C-c C-l" . python-shell-send-file))
  :hook (((python-mode python-ts-mode) . my-python-setup)
         ((python-mode python-ts-mode) . eglot-ensure))
  :init
  (setq python-indent-guess-indent-offset-verbose nil)
  :config
  (with-eval-after-load 'evil
    (evil-define-key 'visual python-mode-map
      (kbd "C-c C-c") #'python-shell-send-region
      (kbd "C-c C-r") #'python-shell-send-region)))

(use-package eglot
  :ensure nil
  :defer t)

(defun my-python-setup ()
  "Buffer-local setup for Python modes."
  (display-line-numbers-mode 1)
  (hs-minor-mode 1)
  (highlight-numbers-mode 1))

(provide 'python-config)
;;; python-config.el ends here
