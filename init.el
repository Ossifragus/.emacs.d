;; set frame for different computers
(cond
 ((string-equal (system-name) "T1700")
  (progn
    (setq default-frame-alist
	  '((top . 0) (left . 0) (height . 100) (width . 81)))
    (add-to-list 'default-frame-alist '(font . "Monospace-14"))))
 ((string-equal (system-name) "W319")
  (progn
    (setq default-frame-alist
	  '((top . 0) (left . 760) (height . 56) (width . 81)))
    (add-to-list 'default-frame-alist '(font . "Monospace-16"))))
 ((string-equal (system-name) "XPS7390")
  (progn
    (setq default-frame-alist
	  '((top . 0) (left . 0) (height . 100) (width . 81)))
    (add-to-list 'default-frame-alist '(font . "Monospace-14"))))
 )

(set-frame-font "16")

(setq default-directory "~/")
;; (add-to-list 'load-path "~/Dropbox/mydoc/reinstallOS/Lisp")
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;Backup file direcory
(setq backup-directory-alist '(("." . "~/.emacs.d/.emacs.tmp")))

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
;; ;;; Match Parentheses, enable skeleton-pair insert globally
(electric-pair-mode 1)
(setq electric-pair-preserve-balance nil)
;; Remember the last place
(save-place-mode 1)
;; (desktop-save-mode 1)

;; allow downcase/upcase
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)


(setq auto-save-visited-file-name t)
(setq default-input-method "TeX")

;; (global-set-key ( kbd "C-c s") 'set-mark-command)
(global-set-key ( kbd "C-c c") 'comment-or-uncomment-region)
(global-set-key ( kbd "C-c s") 'ispell-region)
(global-set-key ( kbd "C-c r") 'replace-regexp)
(global-set-key "\C-cy" 'browse-kill-ring)
(global-set-key "\C-xp" (lambda () 
                          (interactive)
                          (other-window -1)))

;;;;;;;;; IDO
;; (require 'ido)
;; (ido-mode t)
;; (setq ido-enable-flex-matching t) ;; enable fuzzy matchings
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-ignore-files '("\.synctex.gz" "\.pdf"))
(setq ido-save-directory-list-file "~/.emacs.d/.emacs.tmp/ido.last")
(ido-mode 1)

;; move the below lines *at the end* of .emacs to ensures  packages
;; installed with package manager overrides other local installation
(require 'package)
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex --shell-escape -synctex=1")
 '(eglot-connect-timeout 300)
 '(inhibit-startup-screen t)
 '(markdown-command "/usr/bin/pandoc")
 '(org-agenda-files '("~/Dropbox/mydoc/web/web.org"))
 '(package-selected-packages
   '(auctex auto-highlight-symbol beacon browse-kill-ring gnu-elpa-keyring-update company-math edit-server edit-server-htmlize eglot eglot-jl ess highlight-indentation highlight-numbers highlight-parentheses julia-repl lsp-mode lsp-julia magit org pdf-tools pdf-view-restore polymode poly-R poly-markdown use-package vterm which-key)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'which-key)
(which-key-mode)

(require 'company-config)
(require 'edit-server-config)
(require 'encoding-config)
(require 'ess-config)
(require 'git-config)
(require 'julia-config)
(require 'latex-config)
(require 'org-config)
(require 'pdf-config)
(require 'polymode-config)
(require 'term-config)
(require 'theme-highlight-config)

(provide 'init)
;;; init ends here
