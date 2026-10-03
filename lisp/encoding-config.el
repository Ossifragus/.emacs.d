;;; encoding-config.el -*- lexical-binding: t; -*-

;; Set UTF-8 as the primary language environment and coding system
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq-default pathname-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; Fontset configurations for symbols/emoji
(defun my-emoji-fonts (&optional frame)
  "Configure symbol and emoji fallback fonts."
  (set-fontset-font t 'symbol "JuliaMono" frame)
  (set-fontset-font t 'symbol "Symbola" frame 'append))

(if (daemonp)
    (add-hook 'after-make-frame-functions #'my-emoji-fonts)
  (my-emoji-fonts))

(provide 'encoding-config)
;;; encoding-config.el ends here
