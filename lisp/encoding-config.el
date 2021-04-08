;;;;;;;;;;;for chinese
;; (set-language-environment 'Chinese-GB)
;; (set-clipboard-coding-system 'euc-cn)
;; (set-buffer-file-coding-system 'euc-cn)
;; (set-selection-coding-system 'euc-cn)
;; (setq default-process-coding-system '(euc-cn . euc-cn))
(modify-coding-system-alist 'process "*" 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))
(setq-default pathname-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; ;; Emoji: 󠁧󠁢󠁳󠁣󠁴󠁿
;; (set-fontset-font t 'symbol "Noto Color Emoji")
;; (set-fontset-font t 'symbol "Symbola" nil 'append)
(defun my-emoji-fonts ()
  (set-fontset-font t 'symbol "Noto Color Emoji")
  (set-fontset-font t 'symbol "Symbola" nil 'append))

(if (daemonp)
    (add-hook 'server-after-make-frame-hook #'my-emoji-fonts)
  (my-emoji-fonts))

(provide 'encoding-config)

;; ;;; Chinese input
;; (use-package pyim
;;   :ensure t
;;   :config
;;   (setq default-input-method "pyim")
;;   (setq pyim-page-length 10)
;; ;;; fuzzy pinyin
;;   (setq pyim-fuzzy-pinyin-alist
;;         '(("c" "ch")
;;           ("s" "sh")
;;           ("z" "zh")
;;           ("en" "eng")
;;           ("in" "ing"))
;;         )
;;   )
;; (use-package pyim-basedict
;;   :ensure t
;;   :config
;;   (pyim-basedict-enable))

;; (provide 'init-chinese)
;; ;;; init-chinese.el ends here
