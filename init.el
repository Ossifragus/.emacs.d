;; w319
(setq default-frame-alist '((top . 0) (left . 760) (height . 56) (width . 81)))
(add-to-list 'default-frame-alist '(font . "Monospace-16"))

(set-frame-font "16")
;; (set-default-font "16")

(setq default-directory "~/")
(add-to-list 'load-path "~/Dropbox/.Emacs")

;; show current buffer name in title bar
(setq frame-title-format "%b")

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
   '(anaconda-mode elpy auctex auto-highlight-symbol beacon browse-kill-ring gnu-elpa-keyring-update company-math edit-server edit-server-htmlize eglot eglot-jl highlight-parentheses highlight-numbers lsp-mode lsp-julia magit org pdf-tools pdf-view-restore polymode poly-R poly-markdown use-package vterm)))



;color color color
(set-background-color "Black")
(set-foreground-color "White")
(set-face-background 'mode-line "lightgoldenrod2")
(set-face-foreground 'mode-line "DarkSlateGray")
(set-cursor-color "Orchid")
(set-face-foreground 'font-lock-comment-face "chocolate4")
(set-face-foreground 'font-lock-string-face "Gold3")
(set-face-foreground 'font-lock-function-name-face "LightBlue")
(set-face-foreground 'font-lock-keyword-face "cyan1")
(set-face-foreground 'font-lock-type-face "Violet")
(set-face-foreground 'font-lock-builtin-face "Cyan")
(set-face-foreground 'font-lock-variable-name-face "Gold")
(set-face-foreground 'font-lock-constant-face "Magenta")
(set-face-foreground 'scroll-bar "Wheat")
(set-face-background 'scroll-bar "lightgoldenrod2")
(set-face-foreground 'tool-bar "Wheat")
(set-face-background 'tool-bar "lightgoldenrod2")
(set-face-foreground 'font-lock-builtin-face "Cyan")
(set-face-foreground 'minibuffer-prompt "GreenYellow")

(add-to-list 'default-frame-alist '(foreground-color . "White"))
(add-to-list 'default-frame-alist '(background-color . "Black"))
(add-to-list 'default-frame-alist '(cursor-color . "Orchid"))

;Backup file direcory
(setq backup-directory-alist '(("." . "~/.emacs.d/.emacs.tmp")))

;; 'y' for 'yes', 'n' for 'no'
(fset 'yes-or-no-p 'y-or-n-p)

;; (global-set-key ( kbd "C-c s") 'set-mark-command)
(global-set-key ( kbd "C-c c") 'comment-or-uncomment-region)
(global-set-key ( kbd "C-c s") 'ispell-region)
(global-set-key ( kbd "C-c r") 'replace-regexp)

;; replace the active region just by typing text
(delete-selection-mode t)

;; disable the toolbar
(tool-bar-mode -1)

;; disable scrollbar
(scroll-bar-mode -1)

;; disable the welcome window
(setq inhibit-startup-message t)

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

;; ;;; Match Parentheses, enable skeleton-pair insert globally
;; (setq skeleton-pair t)
;; (global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
;; (global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
;; (global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
;; (global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)

;; (add-hook 'c-mode-common-hook 'hpm-on)
;; (defun my-c-mode-auto-pair ()
;;   (setq skeleton-pair t)
;;   (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
;;   (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
;;   (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
;;   (local-set-key (kbd "[") 'skeleton-pair-insert-maybe))
;; (add-hook 'c-mode-hook 'my-c-mode-auto-pair)
;; (add-hook 'c++-mode-hook 'my-c-mode-auto-pair)
;; ;; (add-hook 'html-mode-hook 'my-c-mode-auto-pair)

(electric-pair-mode 1)
(setq electric-pair-preserve-balance nil)

;; ;;; find matched Parentheses
;; ;; (global-set-key "@" 'match-paren)
;; (global-set-key ( kbd "C-c @") 'match-paren)
;; (defun match-paren (arg)
;;   "Go to the matching paren if on a paren; otherwise insert %."
;;   (interactive "p")
;;   (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;; 	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;; 	(t (self-insert-command (or arg 1)))))

;; CUA mode
;; (cua-mode nil)
;; (cua-selection-mode nil)
;; ;; (setq cua-auto-tabify-rectangles nil)
;; ;; (setq cua-enable-cua-keys nil)

;;; Highlight Parentheses
;; (show-paren-mode 1)
;; (setq show-paren-delay 0)
(require 'highlight-parentheses)
(setq hl-paren-colors '("red" "blue" "yellow" "green" "IndianRed" "cyan" "orange"  "magenta"))
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;; ;; start the server
;; (server-start)

;; allow downcase/upcase
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; Remember the last place
(save-place-mode 1)
;; (desktop-save-mode 1)

;;;;;;;;; IDO
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matchings
(setq ido-ignore-files '("\.synctex.gz" "\.pdf"))
(setq ido-save-directory-list-file "~/.emacs.d/.emacs.tmp/ido.last")

(require 'ediff)
;; (require 'dictem)
(setq ispell-program-name "aspell")

(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'text-mode-hook 'visual-line-mode)


;Tex Tex Tex Tex Tex Tex Tex Tex Tex Tex Tex Tex Tex Tex 
;; (require 'tex-site)

(add-hook 'latex-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-auctex t)
(setq preview-scale-function 1.5)
(setq TeX-auto-save nil)
;; (setq TeX-auto-save t)
(setq TeX-PDF-mode t)
(setq TeX-save-query  nil)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)

(defun my-LaTeX-hook ()
  (local-set-key (kbd "C-c C-f") 'tex-frame)
  ;; (setq skeleton-pair t)
  ;; (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  ;; (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  ;; (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
  ;; (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "$") 'insert-dollor-sign)
  (setq TeX-parse-self t)
  (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)
  (tex-fold-mode t)
  (flyspell-mode t)
  ;; (local-set-key (kbd "C-c f") 'beamer-template-frame)
  ;; (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
  ;; (local-set-key (kbd "C-c m") 'flymake-start-syntax-check)
  ;; (local-set-key (kbd "C-c n") 'flymake-goto-next-error)
  ;; flymake replaced by flycheck
  ;; (outline-minor-mode t)
  )

(defun insert-dollor-sign ()
  (interactive)
  (insert "$$")
  (backward-char 1))

(add-hook 'LaTeX-mode-hook 'my-LaTeX-hook)

(defun tex-frame ()
  "Run pdflatex on current frame.  
Frame must be declared as an environment."
  (interactive)
  (let (beg)
    (save-excursion
      (search-backward "\\begin{frame}")
      (setq beg (point))
      (forward-char 1)
      (LaTeX-find-matching-end)
      (TeX-pin-region beg (point))
      (letf (( (symbol-function 'TeX-command-query) (lambda (x) "LaTeX")))
        (TeX-command-region)))))

;; (defun beamer-template-frame ()
;;   "Create a simple template and move point to after \\frametitle."
;;   (interactive)
;;   (LaTeX-environment-menu "frame")
;;   ;; ;; (insert "\\frametitle{}\timing")
;;   ;; (insert "\\timing")
;;   ;; (newline-and-indent)
;;   ;; ;; (backward-char 8)
;;   )

(setq bibtex-align-at-equal-sign t)

;; (require 'flymake)
;; (defun flymake-get-tex-args (file-name)
;; (list "pdflatex"
;; (list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))

(setq TeX-source-correlate-mode t)

;; ;; Alternative 1: For some users, `x-focus-frame' works.
;; (setq TeX-raise-frame-function #'x-focus-frame)

;; ;; Alternative 2: Under GNOME 3.20 (and probably others), it
;; ;; seems some focus stealing prevention policy prohibits that
;; ;; some window gets the focus immediately after the user has
;; ;; clicked in some other window.  Here waiting a bit before
;; ;; issuing the request seems to work.
;; (setq TeX-raise-frame-function
;;       (lambda ()
;; 	(run-at-time 0.5 nil #'x-focus-frame)))

;; Alternative 3: Use the external wmctrl tool in order to
;; force Emacs into the focus.
(setq TeX-raise-frame-function
      (lambda ()
	(call-process
	 "wmctrl" nil nil nil "-i" "-R"
	 (frame-parameter (selected-frame) 'outer-window-id))))

;ESS ESS ESS ESS ESS ESS ESS ESS ESS ESS ESS ESS ESS ESS ESS 
(setq ess-swv-plug-into-AUCTeX-p t)
(setq ess-ask-for-ess-directory nil)
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)
(setq ess-eval-visibly-p nil)
(add-to-list 'load-path "~/Dropbox/.Emacs/ess-18.10.2/lisp")
;; (require 'ess-site)
(require 'ess-r-mode)
(ess-toggle-underscore nil)
;; (setq ess-long+replacement "")

;;C++C++C++C++C++C++C++C++C++C++C++C++C++C++C++C++C++C++C++
;; (set 'compile-command' "R CMD SHLIB ")

;; Add the below lines *at the end* of your .emacs. This
;; ensures that packages installed with package manager
;; overrides other local installation
(require 'package)
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;; (elpy-enable)
;; (setq python-shell-virtualenv-path "/home/ossifragus/anaconda3/")
;; (setq elpy-rpc-python-command "/home/ossifragus/anaconda3/bin/python")
;; (setq python-shell-interpreter "/home/ossifragus/anaconda3/bin/python")
;; (add-hook 'python-mode-hook 'anaconda-mode)
;; (define-key elpy-mode-map (kbd "C-c C-r") 'elpy-shell-send-region-or-buffer)
;; (defun my-elpy-mode-hook-fun ()
;;  "Function to be installed in `elpy-mode-hook'."
;;  ;; (local-set-key (kbd "C-c C-r") 'elpy-shell-send-region-or-buffer-and-go)
;;  ;; (cua-selection-mode -1)
;;  (company-mode t)
;; )
;; (add-hook 'elpy-mode-hook 'my-elpy-mode-hook-fun)
;; ;; (add-hook 'after-init-hook 'global-company-mode)

;; ;; Gmail
;; (setq gnus-select-method '(nnimap "gmail"
;; 				  (nnimap-address "imap.gmail.com")
;; 				  (nnimap-server-port 993)
;; 				  (nnimap-stream ssl)))

;; (setq message-send-mail-function 'smtpmail-send-it
;;       smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials '(("smtp.gmail.com" 587 "whygps@gmail.com" nil))
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587
;;       smtpmail-local-domain "yourcompany.com")

;; (setq gnus-thread-sort-functions
;;       '(
;;         (not gnus-thread-sort-by-date)
;;         (not gnus-thread-sort-by-number)
;;         ))

;; polymodel
;; (setq load-path
;;       (append '("~/Dropbox/.Emacs/polymode/"
;; 		"~/Dropbox/.Emacs/poly-markdown/"
;; 		"~/Dropbox/.Emacs/poly-noweb/"
;; 		"~/Dropbox/.Emacs/poly-R/")
;;               load-path))
(require 'poly-R)
;; (require 'poly-noweb)
;; (require 'poly-markdown)
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))

;; (require 'openwith)
;; (openwith-mode t)
;; (setq openwith-associations '(("\\.pdf\\'" "evince" (file))))

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key "\C-xp" (lambda () 
                          (interactive)
                          (other-window -1)))

;; ;; CUA mode
;; (cua-selection-mode t)
;; (setq cua-auto-tabify-rectangles nil) 

; show line number
;; (when (version<= "26.0.50" emacs-version )
;;   (global-display-line-numbers-mode))

;; ;; (load "~/Emacs/htmlize.el")
;; (require 'htmlize)
;; ;;(setq htmlize-output-type "css")
;; ;;(setq htmlize-output-type "inline-css")
;; (setq htmlize-output-type "font")

;; ;;;;;;;; MatLab
;; (setq load-path (cons "~/Dropbox/.Emacs/matlab/" load-path))
;; (load-library "matlab-load")
;;     ;; (matlab-cedet-setup)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun my-markdown-hook ()
  ;; (setq skeleton-pair t)
  ;; (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  ;; (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  ;; (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
  ;; (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
  (tex-fold-mode t)
  (flyspell-mode t)
  (visual-line-mode t)
  ;; (outline-minor-mode t)
  )
(add-hook 'markdown-mode-hook 'my-markdown-hook)

(add-to-list 'load-path "~/Dropbox/.Emacs/julia-emacs")
(require 'julia-mode)
(add-to-list 'load-path "~/Dropbox/.Emacs/julia-repl")
(require 'julia-repl)
(julia-repl-set-terminal-backend 'vterm)
(setq vterm-kill-buffer-on-exit nil)

(defun my-julia-hook ()
  (highlight-indentation-mode t)
  (auto-highlight-symbol-mode t)
  (julia-repl-mode t)
  )
(add-hook 'julia-mode-hook 'my-julia-hook)
;; (add-hook 'julia-mode-hook 'julia-repl-mode) ;; always use minor mode
(setenv "JULIA_NUM_THREADS" "4")

(setq auto-save-visited-file-name t)
(setq default-input-method "TeX")

(require 'org)
;; (require 'org-ref)

;; (require 'edit-server)
;; (edit-server-start)

(when (locate-library "edit-server")
  (require 'edit-server)
  ;; (setq edit-server-new-frame nil)
  (edit-server-start))

(autoload 'edit-server-maybe-dehtmlize-buffer "edit-server-htmlize" "edit-server-htmlize" t)
(autoload 'edit-server-maybe-htmlize-buffer   "edit-server-htmlize" "edit-server-htmlize" t)
(add-hook 'edit-server-start-hook 'edit-server-maybe-dehtmlize-buffer)
(add-hook 'edit-server-start-hook 'LaTeX-mode)
;; (add-hook 'edit-server-start-hook 'org-mode)
(add-hook 'edit-server-done-hook  'edit-server-maybe-htmlize-buffer)

(use-package pdf-tools
  :ensure t
  :config
  ;; (pdf-tools-install)
  (pdf-loader-install)
  )
(use-package pdf-view-restore
  :after pdf-tools
  :config
  (add-hook 'pdf-view-mode-hook 'pdf-view-restore-mode))
(setq pdf-view-restore-filename "~/.emacs.d/.emacs.tmp/.pdf-view-restore")

(global-auto-revert-mode 1)

;; self defined poly mode
;; (define-hostmode poly-tex+r-hostmode
;;   :mode 'LaTeX-mode)
;; (define-innermode poly-tex+r-innermode
;;   :mode 'ess-r-mode
;;   :head-matcher (cons "^[ \t]*\\(%\s<<.*\n\\)" 1)
;;   :tail-matcher (cons "^[ \t]*\\(%\s>>.*\\)$" 1)
;;   ;; :head-matcher (cons "^[ \t]*\\(%<<\\(.*\\)>>=.*\n\\)" 1)
;;   ;; :tail-matcher (cons "^[ \t]*\\(%@.*\\)$" 1)
;;   :head-mode 'host
;;   :tail-mode 'host)
;; (define-polymode poly-tex+r-mode  ;; poly-noweb-mode
;;   :hostmode 'poly-tex+r-hostmode
;;   :innermodes '(poly-tex+r-innermode))

;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((emacs-lisp . nil)
;;    (R . t)
;;    (shell . t)))

(add-hook 'after-init-hook 'global-company-mode)
;; (add-to-list 'load-path
;;               "~/.emacs.d/elpa/yasnippet-20200604.246")
;;               ;; "~/.emacs.d/elpa/yasnippet-0.14.0")
;; (require 'yasnippet)
(yas-global-mode 1)

(global-hl-line-mode 1)
(set-face-attribute 'hl-line nil :inherit nil :background "gray11")

(beacon-mode 1)

(require 'highlight-numbers)
;; (add-hook 'julia-mode-hook 'highlight-numbers-mode)
;; (add-hook 'prog-mode-hook 'highlight-numbers-mode)
(set-face-foreground 'highlight-numbers-number "purple3")

(add-to-list 'auto-mode-alist '("\\.org.txt" . org-mode))

;; ;; Emoji: 󠁧󠁢󠁳󠁣󠁴󠁿
;; (set-fontset-font t 'symbol "Noto Color Emoji")
;; (set-fontset-font t 'symbol "Symbola" nil 'append)
(defun my-emoji-fonts ()
  (set-fontset-font t 'symbol "Noto Color Emoji")
  (set-fontset-font t 'symbol "Symbola" nil 'append))

(if (daemonp)
    (add-hook 'server-after-make-frame-hook #'my-emoji-fonts)
  (my-emoji-fonts))

(setq-default fill-column 80)
(global-display-fill-column-indicator-mode 1)
(setq column-number-mode t)

(global-set-key "\C-cy" 'browse-kill-ring)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-term)

(provide 'init)
;;; init ends here
