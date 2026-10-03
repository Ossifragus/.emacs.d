;;; paren-config.el -*- lexical-binding: t; -*-

;;; Built-in show-paren-mode
(use-package paren
  :ensure nil
  :init
  (setq show-paren-delay 0)
  :config
  (show-paren-mode 1)
  (set-face-attribute 'show-paren-match nil
                      :background "Black"
                      :foreground "#def"
                      :weight 'extra-bold))

;;; Smartparens: Auto-pairing and delimiter management
(use-package smartparens
  :ensure t
  :hook ((prog-mode text-mode) . smartparens-mode)
  :config
  (require 'smartparens-config))

;;; Highlight Parentheses: Rainbow highlighting around point
(use-package highlight-parentheses
  :ensure t
  :init
  (setq highlight-parentheses-colors
        '("red" "yellow" "green" "IndianRed" "cyan" "orange" "magenta" "purple"))
  :config
  (global-highlight-parentheses-mode 1))

(provide 'paren-config)
;;; paren-config.el ends here
