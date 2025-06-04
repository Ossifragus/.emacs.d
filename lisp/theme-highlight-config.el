(set-background-color "Black")
(set-foreground-color "White")
(set-face-background 'mode-line "lightgoldenrod2")
(set-face-foreground 'mode-line "DarkSlateGray")
(set-cursor-color "Orchid")
(set-face-foreground 'font-lock-comment-face "chocolate4")
(set-face-foreground 'font-lock-string-face "forest green"); Gold3
(set-face-foreground 'font-lock-function-name-face "deep sky blue");; SeaGreen1
(set-face-foreground 'font-lock-keyword-face "cyan1"); firebrick
(set-face-foreground 'font-lock-type-face "Violet")
(set-face-foreground 'font-lock-builtin-face "Cyan")
(set-face-foreground 'font-lock-variable-name-face "Gold")
(set-face-foreground 'font-lock-constant-face "Magenta")
(set-face-foreground 'scroll-bar "Wheat")
(set-face-background 'scroll-bar "lightgoldenrod2")
(set-face-foreground 'tool-bar "Wheat")
(set-face-background 'tool-bar "lightgoldenrod2")
(set-face-foreground 'font-lock-builtin-face "Cyan")
(set-face-foreground 'minibuffer-prompt "GreenYellow")
(set-face-background 'mode-line-inactive "tomato4")
;; (set-face-background 'mode-line-inactive "goldenrod")
;; (set-face-background 'mode-line-inactive "gray11")

(add-to-list 'default-frame-alist '(foreground-color . "White"))
(add-to-list 'default-frame-alist '(background-color . "Black"))
(add-to-list 'default-frame-alist '(cursor-color . "Orchid"))

(use-package highlight-numbers
  :ensure t
  )
(require 'highlight-numbers)
;; (add-hook 'julia-mode-hook 'highlight-numbers-mode)
;; (add-hook 'prog-mode-hook 'highlight-numbers-mode)
(set-face-foreground 'highlight-numbers-number "light salmon")

;; highlight current line
(global-hl-line-mode 1)
(set-face-attribute 'hl-line nil :inherit nil :background "gray11")

;; shine on top of your cursor so you know where it is
(use-package beacon
  :ensure t
  :config
  (beacon-mode 1)
  )

;; column width
(setq-default fill-column 80)
;; fill column indicator
(global-display-fill-column-indicator-mode 1)
;; show column number
(setq column-number-mode t)

;; load theme - pkg: color-theme-sanityinc-tomorrow
(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init
  (setq custom-safe-themes t)
  :config
  (require 'color-theme-sanityinc-tomorrow)
  (setq-default custom-enabled-themes '(sanityinc-tomorrow-bright))
  (color-theme-sanityinc-tomorrow--define-theme bright)
  (load-theme 'sanityinc-tomorrow-bright t))

(window-divider-mode 1) ;; This has to be after color-theme-sanityinc-tomorrow

(use-package auto-highlight-symbol
  :ensure t
  )

(use-package beacon ; Never lose your cursor again
  :ensure t
  :config
  (beacon-mode 1)
  )

(provide 'theme-highlight-config)

