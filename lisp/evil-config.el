(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (global-undo-tree-mode) ;; need undo tree before Emacs 28
  (evil-set-undo-system 'undo-tree)
  )

(use-package evil-better-visual-line
  :ensure t
  :config
  (evil-better-visual-line-on)
  )

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1)
  )

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;;; esc quits
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(provide 'evil-config)

;; ;; Enable Evil
;; (require 'evil)
;; (evil-mode 1)
;; (global-undo-tree-mode) ;; need undo tree before Emacs 28
;; (evil-set-undo-system 'undo-tree)
;; (use-package evil-better-visual-line
;;   :ensure t
;;   :config
;;   (evil-better-visual-line-on))
;; (require 'evil-surround)
;; (global-evil-surround-mode 1)

