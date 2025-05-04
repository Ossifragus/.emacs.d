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

(use-package evil-matchit
  :ensure t
  :config
	(global-evil-matchit-mode 1)
  )

(use-package evil-visual-mark-mode
  :ensure t
  :config
  (evil-visual-mark-mode 0)
  )

;;; esc quits
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

;;; basic emacs commands
(define-key evil-normal-state-map "\C-y" 'yank)
(define-key evil-insert-state-map "\C-y" 'yank)
(define-key evil-visual-state-map "\C-y" 'yank)
(define-key evil-insert-state-map "\C-e" 'end-of-line)
(define-key evil-insert-state-map "\C-n" 'next-line)
;; (define-key evil-normal-state-map "\C-w" 'evil-delete)
;; (define-key evil-insert-state-map "\C-w" 'evil-delete)
;; (define-key evil-visual-state-map "\C-w" 'evil-delete)
(define-key evil-insert-state-map "\C-p" 'previous-line)
(define-key evil-insert-state-map "\C-r" 'search-backward)

(unless (display-graphic-p)
	;; (require 'evil-terminal-cursor-changer)
  (use-package evil-terminal-cursor-changer
    :ensure t)
	(evil-terminal-cursor-changer-activate) ; or (etcc-on)
	)
(setq evil-motion-state-cursor 'box)  ; █
(setq evil-visual-state-cursor 'box)  ; █
(setq evil-normal-state-cursor 'box)  ; █
(setq evil-insert-state-cursor 'bar)  ; ⎸
(setq evil-emacs-state-cursor  'hbar) ; _

(use-package evil-extra-operator ; gG google search
  :ensure t
  :config
  (global-evil-extra-operator-mode 1)
  )

(use-package evil-tex
  :ensure t
  )
(use-package evil-textobj-line
  :ensure t
  )
(require 'evil-textobj-line)

(evil-set-leader 'motion (kbd "SPC"))
(evil-set-leader 'normal (kbd "SPC"))
(evil-set-leader 'visual (kbd "SPC"))

(evil-define-key 'normal 'global (kbd "<leader>fs") 'save-buffer)
;;; Leader
;; (define-prefix-command 'my-leader-map)

;; (keymap-set evil-motion-state-map "SPC" 'my-leader-map)
;; (keymap-set evil-normal-state-map "SPC" 'my-leader-map)

;; (evil-define-key nil my-leader-map
;;     ;; add your bindings here:
;;     "b"  'switch-to-buffer
;;     "B"  'project-switch-to-buffer
;;     "pf" 'project-find-file
;;     "ps" 'project-shell-command
;;     "l" 'julia-repl-send-line
;;     ;; etc.
;;     )

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

;; (add-hook 'LaTeX-mode-hook
;; 					(lambda ()
;;             (push '(?\} . ("\{" . "\}")) evil-surround-pairs-alist)
;; 						))
;; (lambda ()
;;       (add-to-list 'evil-embrace-evil-surround-keys ?o)))
;; (evil-embrace-enable-evil-surround-integration)
