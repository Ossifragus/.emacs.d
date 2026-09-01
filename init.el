(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
; not write package-selected-packages
;; (defun package--save-selected-packages (&rest opt) nil)
(setq custom-file "~/.emacs.d/var/custom.el")
;; (load custom-file)

(use-package no-littering
  :ensure t
  ;; :vc (:url "https://github.com/emacscollective/no-littering.git"
  ;;           :rev :newest)
  :config
  (require 'no-littering))
;; (add-to-list 'default-frame-alist '(layers . nil)) ;; for GPU
;; (setq frame-inhibit-implied-resize t)
;; (add-to-list 'default-frame-alist '(visibility . t))
;; (setq x-gtk-use-system-tooltips nil)
;; (setq pgtk-use-im-context-on-new-connection t)
;; (add-to-list 'default-frame-alist '(focus-handling . t))
;; (add-to-list 'default-frame-alist '(no-focus-on-map . t))
;; (add-to-list 'default-frame-alist '(undecorated . nil))
(setq pgtk-wait-for-event-finish t)

;; (setq default-directory "~/Dropbox/")
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(setq backup-directory-alist '(("." . "~/.emacs.d/var/backup")))

(fset 'yes-or-no-p 'y-or-n-p)    ;; 'y' for 'yes', 'n' for 'no'
(delete-selection-mode t)        ;; replace the active region by typing
(tool-bar-mode -1)               ;; disable the toolbar
(scroll-bar-mode -1)             ;; disable scrollbar
(setq inhibit-startup-message t) ;; disable the welcome window
(setq frame-title-format "%b")   ;; show current buffer name in title bar
(global-auto-revert-mode 1)      ;; revert buffer when file changes on disk
(save-place-mode 1)              ;; Remember the last place
(auto-save-visited-mode t)
(which-key-mode)
;; (desktop-save-mode 1)
;; (setq-default tab-width 2) ;; set tab width

(global-set-key ( kbd "C-c c") 'comment-or-uncomment-region)
(global-set-key ( kbd "C-c s") 'ispell-region)
(global-set-key ( kbd "C-c r") 'replace-regexp)
;; (global-set-key "\C-xp" (lambda () (interactive) (other-window -1)))

(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'text-mode-hook 'visual-line-mode)

(setq-default indent-tabs-mode nil)

(use-package vundo
  :ensure t
  :bind ("C-x u" . vundo)
  :config
  (setq vundo-glyph-alist vundo-unicode-symbols))

(require 'encoding-config)
(require 'system-config)
(require 'theme-highlight-config)
(require 'polymode-config)
(require 'evil-config)
(require 'completion-config)
(require 'chatgpt-config)
(require 'edit-server-config)
(require 'ess-config)
(require 'git-config)
(require 'julia-config)
(require 'kill-ring-config)
(require 'latex-config)
(require 'org-config)
(require 'paren-config)
;; (require 'pdf-config)
(require 'python-config)
(require 'term-config)
(require 'treesitter-config)

(require 'install-packages)

(setq default-input-method "TeX")

(provide 'init)
;;; init ends here
