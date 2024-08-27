;; different settings for different computers
(cond
 ((or (string= (system-name) "aust319")
      (string= (system-name) "T1700")
      (string= (system-name) "W319"))
  (progn
    (setq default-frame-alist
	  '((top . 0) (left . 72) (height . 56) (width . 81)))
    ))
 ((or (eq system-type 'darwin) (string= (system-name) "MBP16.local"))
  (progn
    (setq default-frame-alist
	  '((top . 0) (left . 0) (height . 100) (width . 81)))
    ;; (setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin/"))  
    ;; (setq exec-path (append exec-path '("/Library/TeX/texbin/")))
    ;; (getenv "PATH")
		(setq markdown-command
					"/usr/local/bin/pandoc -c /Users/haiying/Library/CloudStorage/Dropbox/App/reinstallOS/style/github-pandoc.css --from=markdown -t html5 --highlight-style pygments --standalone --mathjax --quiet --citeproc --template /Users/haiying/Library/CloudStorage/Dropbox/App/reinstallOS/style/GitHub.html")
    (setq TeX-source-correlate-method 'synctex
          TeX-view-program-list   ;; Use Skim, it's awesome
          '(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline -g -b %n %o %b"))
          TeX-view-program-selection '((output-pdf "Skim")))
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

(setq default-directory "~/")
;; (add-to-list 'load-path "~/Dropbox/App/reinstallOS/Lisp")
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

(require 'paren)
(show-paren-mode t)
;; (set-face-background 'show-paren-match (face-foreground 'font-lock-comment-face))
(set-face-background 'show-paren-match "Black")
(set-face-foreground 'show-paren-match "#def")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

(window-divider-mode 1)
(global-auto-revert-mode 1)
;; ;;; Match Parentheses, enable skeleton-pair insert globally
(electric-pair-mode 1)
(setq electric-pair-preserve-balance nil)
;; make electric-pair-mode work on more brackets
(setq electric-pair-pairs '(
														(?\" . ?\")
														(?\{ . ?\})
														) )
;; Remember the last place
(save-place-mode 1)
;; (desktop-save-mode 1)
;; set tab width
(setq-default tab-width 2)

;; allow downcase/upcase
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(auto-save-visited-mode t)
(setq markdown-enable-math t)
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/.emacs.tmp/undo")))

;; (global-set-key ( kbd "C-c s") 'set-mark-command)
(global-set-key ( kbd "C-c c") 'comment-or-uncomment-region)
(global-set-key ( kbd "C-c s") 'ispell-region)
(global-set-key ( kbd "C-c r") 'replace-regexp)
(global-set-key "\C-cy" 'browse-kill-ring)
;; (autoload 'kill-ring-search "kill-ring-search"
;;   "Search the kill ring in the minibuffer."
;;   (interactive))
(global-set-key "\M-\C-y" 'kill-ring-search)
(global-set-key "\C-xp" (lambda () 
                          (interactive)
                          (other-window -1)))

;;;;;;;;; IDO
;; (require 'ido)
;; (ido-mode t)
;; (setq ido-enable-flex-matching t) ;; enable fuzzy matchings
(setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)
(setq ido-ignore-files '("\.synctex.gz" "\.bst"))
(setq ido-save-directory-list-file "~/.emacs.d/.emacs.tmp/ido.last")
(ido-mode 1)

;; move the below lines *at the end* of .emacs to ensures  packages
;; installed with package manager overrides other local installation
(require 'package)
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq custom-file "~/.emacs.d/lisp/custom.el")
(load custom-file)

;; eglot eglot-jl lsp-mode lsp-julia 

(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'text-mode-hook 'visual-line-mode)

(setq-default indent-tabs-mode nil)

(ivy-mode 1)
(counsel-mode 1)
(global-set-key (kbd "C-x C-f") 'ido-find-file)
(setq ivy-re-builders-alist '((swiper . ivy--regex-plus)
                              (t . ivy--regex-fuzzy)))
;; (setq counsel-find-file-ignore-regexp "\\..synctex.gz\\'\\|\\.bst\\'")

(require 'openwith)
(setq openwith-associations '(("\\.pdf\\'" "evince" (file))))
(openwith-mode t)

(require 'company-config)
(require 'edit-server-config)
(require 'encoding-config)
(require 'ess-config)
(require 'evil-config)
(require 'git-config)
(require 'latex)
(require 'julia-config)
(require 'latex-config)
(require 'org-config)
(require 'pdf-config)
(require 'polymode-config)
(require 'python-config)
(require 'term-config)
(require 'theme-highlight-config)
(require 'chatgpt-config)

;; (require 'which-key)
(use-package which-key
  :ensure t)
(which-key-mode)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(when (daemonp)
  (exec-path-from-shell-initialize))

(provide 'init)
;;; init ends here
