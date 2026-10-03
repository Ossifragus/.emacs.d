;;; evil-config.el -*- lexical-binding: t; -*-

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  (setq evil-motion-state-cursor 'box)
  (setq evil-visual-state-cursor 'box)
  (setq evil-normal-state-cursor 'box)
  (setq evil-insert-state-cursor 'bar)
  (setq evil-emacs-state-cursor  'hbar)
  :config
  (evil-mode 1)
  (evil-set-undo-system 'undo-redo)

  ;; ESC quits
  (define-key evil-normal-state-map [escape] #'keyboard-quit)
  (define-key evil-visual-state-map [escape] #'keyboard-quit)
  (define-key minibuffer-local-map [escape] #'abort-minibuffers)

  ;; Emacs standard key equivalents in insert/normal/visual
  (define-key evil-normal-state-map (kbd "C-y") #'yank)
  (define-key evil-insert-state-map (kbd "C-y") #'yank)
  (define-key evil-visual-state-map (kbd "C-y") #'yank)
  (define-key evil-insert-state-map (kbd "C-e") #'end-of-line)
  (define-key evil-insert-state-map (kbd "C-n") #'next-line)
  (define-key evil-insert-state-map (kbd "C-p") #'previous-line)
  (define-key evil-insert-state-map (kbd "C-r") #'search-backward)

  ;; Leader configuration (SPC)
  (evil-set-leader '(normal visual motion) (kbd "SPC"))
  (evil-define-key 'normal 'global (kbd "<leader>fs") #'save-buffer)
  (evil-define-key 'visual 'global (kbd "<leader>gc") #'comment-or-uncomment-region)

  (with-eval-after-load 'agent-shell
    (evil-define-key 'visual 'global (kbd "<leader>aic") #'agent-shell-send-region-to)
    (evil-define-key 'visual 'global (kbd "<leader>ais") #'agent-shell-send-region)))

(use-package evil-better-visual-line
  :ensure t
  :config
  (evil-better-visual-line-on))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-matchit
  :ensure t
  :config
  (global-evil-matchit-mode 1))

(use-package evil-visual-mark-mode
  :ensure t
  :config
  (evil-visual-mark-mode 0))

(use-package evil-terminal-cursor-changer
  :ensure t
  :unless (display-graphic-p)
  :config
  (evil-terminal-cursor-changer-activate))

(use-package evil-extra-operator
  :ensure t
  :config
  (global-evil-extra-operator-mode 1))

(use-package evil-tex
  :ensure t)

(use-package evil-textobj-line
  :ensure t)

(provide 'evil-config)
;;; evil-config.el ends here
