(set-background-color "Black")
(set-foreground-color "White")
(set-face-background 'mode-line "lightgoldenrod2")
(set-face-foreground 'mode-line "DarkSlateGray")
(set-cursor-color "Orchid")
(set-face-foreground 'font-lock-comment-face "chocolate4")
(set-face-foreground 'font-lock-string-face "Gold3")
(set-face-foreground 'font-lock-function-name-face "deep sky blue");; SeaGreen1
(set-face-foreground 'font-lock-keyword-face "cyan1")
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
;; (set-face-background 'mode-line-inactive "goldenrod")
(set-face-background 'mode-line-inactive "gray11")

(add-to-list 'default-frame-alist '(foreground-color . "White"))
(add-to-list 'default-frame-alist '(background-color . "Black"))
(add-to-list 'default-frame-alist '(cursor-color . "Orchid"))

;;; Highlight Parentheses
;; (show-paren-mode 1)
;; (setq show-paren-delay 0)
(require 'highlight-parentheses)
(setq hl-paren-colors '("red" "yellow" "green" "IndianRed" "cyan" "orange"  "magenta", "purple"))
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

(require 'highlight-numbers)
;; (add-hook 'julia-mode-hook 'highlight-numbers-mode)
;; (add-hook 'prog-mode-hook 'highlight-numbers-mode)
(set-face-foreground 'highlight-numbers-number "light salmon")

;; highlight current line
(global-hl-line-mode 1)
(set-face-attribute 'hl-line nil :inherit nil :background "gray11")

;; shine on top of your cursor so you know where it is
(beacon-mode 1)

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

;; colors for vterm
(custom-set-faces
 '(vterm-color-black ((t (:foreground "#3F3F3F" :background "#992323"))))
 ;; '(vterm-color-black ((t (:foreground "#3F3F3F" :background "#2B2B2B"))))
 '(vterm-color-red ((t (:foreground "#AC7373" :background "#8C5353"))))
 '(vterm-color-green ((t (:foreground "#7F9F7F" :background "#9FC59F"))))
 '(vterm-color-yellow ((t (:foreground "#DFAF8F" :background "#9FC59F"))))
 '(vterm-color-blue ((t (:foreground "#7CB8BB" :background "#4C7073"))))
 '(vterm-color-magenta ((t (:foreground "#DC8CC3" :background "#CC9393"))))
 '(vterm-color-cyan ((t (:foreground "#93E0E3" :background "#8CD0D3"))))
 '(vterm-color-white ((t (:foreground "#DCDCCC" :background "#656555"))))
 '(vterm-default-fg-color ((t (:inherit vterm-color-white))))
 '(vterm-default-bg-color ((t (:inherit vterm-color-black))))
 )

(provide 'theme-highlight-config)

