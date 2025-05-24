(require 'paren)
(show-paren-mode t)
;; (set-face-background 'show-paren-match (face-foreground 'font-lock-comment-face))
(set-face-background 'show-paren-match "Black")
(set-face-foreground 'show-paren-match "#def")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

;; ;;; Match Parentheses, enable skeleton-pair insert globally
;; (electric-pair-mode 1)
;; (setq electric-pair-preserve-balance nil)
;; ;; make electric-pair-mode work on more brackets
;; (setq electric-pair-pairs '(
;;                             (?\" . ?\")
;;                             (?\{ . ?\})
;;                             ) )

(use-package smartparens
  :ensure smartparens  ;; install the package
  :hook (prog-mode text-mode markdown-mode org-mode)
  :config
  (require 'smartparens-config))

(provide 'paren-config)

