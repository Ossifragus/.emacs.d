;; https://github.com/jorgenschaefer/elpy/issues/1729
;; M-x elpy-rpc-reinstall-virtualenv
;; pipx install virtualenv
(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))

;; https://emacs.stackexchange.com/questions/47358/can-t-guess-python-indent-offset-delete-warning-when-local-file-variable
(setq python-indent-guess-indent-offset-verbose nil)

(defun my-python-hook ()
  (auto-highlight-symbol-mode t)
  (display-line-numbers-mode t)
  (highlight-indentation-mode t)
  (hs-minor-mode t)
  (highlight-numbers-mode t))
(add-hook 'python-mode-hook 'my-python-hook)

(provide 'python-config)
