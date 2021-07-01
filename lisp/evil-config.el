;; Enable Evil
(require 'evil)
(evil-mode 1)
(global-undo-tree-mode) ;; need undo tree before Emacs 28
(evil-set-undo-system 'undo-tree)
(use-package evil-better-visual-line
  :ensure t
  :config
  (evil-better-visual-line-on))
(require 'evil-surround)
(global-evil-surround-mode 1)
(provide 'evil-config)

