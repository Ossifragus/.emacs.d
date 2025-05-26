(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
; not write package-selected-packages
;; (defun package--save-selected-packages (&rest opt) nil)
(setq custom-file "~/.emacs.d/var/custom.el")
;; (load custom-file)

(use-package no-littering
  :ensure t
  :config
  (require 'no-littering)
  )

;; different settings for different computers
(cond
 ((or (string= (system-name) "aust319")
      (string= (system-name) "T1700")
      (string= (system-name) "yoga")
      (string= (system-name) "W319"))
  (progn
    (setq default-frame-alist
	  '((top . 0) (left . 72) (height . 100) (width . 81)))
    ))
 ((or (eq system-type 'darwin) (string= (system-name) "MBP16.local"))
  (progn
    (setq default-frame-alist
	  '((top . 0) (left . 0) (height . 100) (width . 81)))
    ;; (setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin/"))  
    ;; (setq exec-path (append exec-path '("/Library/TeX/texbin/")))
    ;; (setq mac-option-key-is-meta nil)
    ;; (setq mac-command-key-is-meta t)
    ;; (setq mac-command-modifier 'meta)
    ;; (setq mac-option-modifier nil)
    ))
 )

;; uniform setings for all computers
(set-frame-font "16")
(add-to-list 'default-frame-alist '(font . "JuliaMono-16"))
;; (add-to-list 'default-frame-alist '(font . "Monospace-16"))

(setq default-directory "~/Dropbox/")
;; (add-to-list 'load-path "~/Dropbox/App/reinstallOS/Lisp")
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;Backup file direcory
(setq backup-directory-alist '(("." . "~/.emacs.d/var/backup")))

;; 'y' for 'yes', 'n' for 'no'
(fset 'yes-or-no-p 'y-or-n-p)
;; replace the active region just by typing text
(delete-selection-mode t)
;; disable the toolbar
(tool-bar-mode -1)
;; disable scrollbar
(scroll-bar-mode -1)
;; disable the welcome window
(setq inhibit-startup-message t)
;; show current buffer name in title bar
(setq frame-title-format "%b")

(window-divider-mode 1)
(global-auto-revert-mode 1)

;; Remember the last place
(save-place-mode 1)
(auto-save-visited-mode t)
;; (desktop-save-mode 1)
;; set tab width
;; (setq-default tab-width 2)

;; allow downcase/upcase
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(use-package undo-tree
  :ensure t
  :config
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/var/undo")))
  )

;; (global-set-key ( kbd "C-c s") 'set-mark-command)
(global-set-key ( kbd "C-c c") 'comment-or-uncomment-region)
(global-set-key ( kbd "C-c s") 'ispell-region)
(global-set-key ( kbd "C-c r") 'replace-regexp)
(global-set-key "\C-xp" (lambda () 
                          (interactive)
                          (other-window -1)))

(which-key-mode)

(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'text-mode-hook 'visual-line-mode)

(setq-default indent-tabs-mode nil)

(use-package openwith
  :ensure t
  :config
  (require 'openwith)
  (setq openwith-associations '(("\\.pdf\\'" "evince" (file))))
  (openwith-mode t)
  )

(require 'chatgpt-config)
(require 'completion-config)
(require 'edit-server-config)
(require 'encoding-config)
(require 'ess-config)
(require 'evil-config)
(require 'git-config)
(require 'julia-config)
(require 'kill-ring-config)
(require 'latex-config)
(require 'org-config)
(require 'paren-config)
;; (require 'pdf-config)
(require 'polymode-config)
(require 'python-config)
(require 'term-config)
(require 'theme-highlight-config)
(require 'treesitter-config)

(require 'install-packages)

(setq default-input-method "TeX")

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))
  (when (daemonp)
    (exec-path-from-shell-initialize))
  )

(provide 'init)
;;; init ends here
