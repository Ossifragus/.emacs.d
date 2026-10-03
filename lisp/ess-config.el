;;; ess-config.el -*- lexical-binding: t; -*-

(use-package ess
  :ensure t
  :config
  (with-eval-after-load 'evil
    (evil-define-key '(normal insert) inferior-ess-mode-map
      (kbd "RET") #'inferior-ess-send-input
      [return] #'inferior-ess-send-input))

  (setq-default comint-scroll-to-bottom-on-input t)
  (setq-default comint-scroll-to-bottom-on-output t)
  (setq-default comint-move-point-for-output t)

  (require 'ess-r-mode)

  (setq ess-R-font-lock-keywords
        '((ess-R-fl-keyword:keywords   . t)
          (ess-R-fl-keyword:constants  . t)
          (ess-R-fl-keyword:modifiers  . t)
          (ess-R-fl-keyword:fun-defs   . t)
          (ess-R-fl-keyword:assign-ops . t)
          (ess-R-fl-keyword:%op%       . t)
          (ess-fl-keyword:fun-calls    . t)
          (ess-fl-keyword:numbers      . nil)
          (ess-fl-keyword:operators    . t)
          (ess-fl-keyword:delimiters   . nil)
          (ess-fl-keyword:=            . t)
          (ess-R-fl-keyword:F&T        . t)))

  (setq inferior-ess-r-font-lock-keywords
        '((ess-S-fl-keyword:prompt      . t)
          (ess-R-fl-keyword:keywords    . t)
          (ess-R-fl-keyword:constants   . t)
          (ess-R-fl-keyword:modifiers   . t)
          (ess-R-fl-keyword:messages    . t)
          (ess-R-fl-keyword:fun-defs    . t)
          (ess-R-fl-keyword:assign-ops  . t)
          (ess-R-fl-keyword:%op%        . t)
          (ess-fl-keyword:matrix-labels . t)
          (ess-fl-keyword:fun-calls     . t)
          (ess-fl-keyword:numbers       . nil)
          (ess-fl-keyword:operators     . t)
          (ess-fl-keyword:delimiters    . nil)
          (ess-fl-keyword:=            . t)
          (ess-R-fl-keyword:F&T        . t)))

  :bind (
         :map ess-r-mode-map
              ("_" . ess-insert-assign)
         :map inferior-ess-r-mode-map
              ("_" . ess-insert-assign)))

(defun my-ess-mode-setup ()
  "Setup hook for `ess-mode'."
  (display-line-numbers-mode 1))

(add-hook 'ess-mode-hook #'my-ess-mode-setup)

(provide 'ess-config)
