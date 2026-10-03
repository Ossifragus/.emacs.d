;;; term-config.el -*- lexical-binding: t; -*-

(use-package vterm
  :ensure t
  :config
  ;; Automatically delete empty closing pair on backspace: () -> empty
  (defun vterm-remove-empty-pairs ()
    "Delete matching closing delimiter if backspacing an empty pair."
    (when (or (and (char-equal (following-char) ?\)) (char-equal (char-before) ?\())
              (and (char-equal (following-char) ?\}) (char-equal (char-before) ?\{))
              (and (char-equal (following-char) ?\]) (char-equal (char-before) ?\[)))
      (vterm-send-C-d)))

  (advice-add 'vterm-send-backspace :before #'vterm-remove-empty-pairs)

  ;; Evil integration: ensure C-y yanks in insert state
  (with-eval-after-load 'evil
    (evil-define-key 'insert vterm-mode-map (kbd "C-y") #'vterm-yank)))

(provide 'term-config)
;;; term-config.el ends here
