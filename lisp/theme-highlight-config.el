;;; theme-highlight-config.el -*- lexical-binding: t; -*-

(add-to-list 'default-frame-alist '(foreground-color . "White"))
(add-to-list 'default-frame-alist '(background-color . "Black"))
(add-to-list 'default-frame-alist '(cursor-color . "Orchid"))

(use-package hl-line
  :config
  (global-hl-line-mode 1))

;; Theme: color-theme-sanityinc-tomorrow
(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init
  (setq custom-safe-themes t)
  :config
  (setq-default custom-enabled-themes '(sanityinc-tomorrow-bright))
  (load-theme 'sanityinc-tomorrow-bright t)

  ;; Face overrides applied across all frames
  (custom-set-faces
   '(default ((t (:background "Black" :foreground "White"))))
   '(mode-line ((t (:background "lightgoldenrod2" :foreground "DarkSlateGray"))))
   '(mode-line-inactive ((t (:background "tomato4"))))
   '(minibuffer-prompt ((t (:foreground "GreenYellow"))))
   '(font-lock-comment-face ((t (:foreground "chocolate4"))))
   '(font-lock-string-face ((t (:foreground "forest green"))))
   '(font-lock-function-name-face ((t (:foreground "deep sky blue"))))
   '(font-lock-keyword-face ((t (:foreground "cyan1"))))
   '(font-lock-type-face ((t (:foreground "Violet"))))
   '(font-lock-builtin-face ((t (:foreground "Cyan"))))
   '(font-lock-variable-name-face ((t (:foreground "Gold"))))
   '(font-lock-constant-face ((t (:foreground "Magenta"))))
   '(hl-line ((t (:inherit nil :background "gray11"))))))

(window-divider-mode 1)

(use-package highlight-numbers
  :ensure t
  :config
  (set-face-foreground 'highlight-numbers-number "light salmon"))

(use-package highlight-indentation
  :ensure t)

;; Column settings
(setq-default fill-column 80)
(global-display-fill-column-indicator-mode 1)
(column-number-mode 1)

(use-package auto-highlight-symbol
  :ensure t)

(use-package beacon
  :ensure t
  :config
  (beacon-mode 1))

(provide 'theme-highlight-config)
;;; theme-highlight-config.el ends here
