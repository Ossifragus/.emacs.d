;; polymodel
;; (setq load-path
;;       (append '("~/Dropbox/.Emacs/polymode/"
;; 		"~/Dropbox/.Emacs/poly-markdown/"
;; 		"~/Dropbox/.Emacs/poly-noweb/"
;; 		"~/Dropbox/.Emacs/poly-R/")
;;               load-path))
 
(use-package polymode
  :ensure t)
(use-package impatient-showdown
  :ensure t
  :defer t)
(use-package quarto-mode
  :ensure t
  :defer t)
(use-package poly-markdown
  :ensure t
  :defer t)
(use-package poly-R
  :ensure t
  :defer t)
(use-package poly-noweb
  :ensure t
  :defer t)
;; (require 'poly-noweb)
;; (require 'poly-markdown)
(add-to-list 'auto-mode-alist '("\\.Rmd\\'" . poly-markdown+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rnw\\'" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rtex\\'" . poly-noweb+r-mode))

(defun my-markdown-hook ()
  (tex-fold-mode t)
  (flyspell-mode t)
  (visual-line-mode t)
  (setq dnd-protocol-alist nil)
  (setq markdown-enable-math t)
  ;; (outline-minor-mode t)
  )
(add-hook 'markdown-mode-hook 'my-markdown-hook)

(cond
 ((eq system-type 'gnu/linux)
  (progn
    (setq markdown-command
          "pandoc -c /home/ossifragus/Dropbox/App/reinstallOS/style/github-pandoc.css --from=markdown -t html5 --highlight-style pygments --standalone --mathjax --quiet --citeproc --template /home/ossifragus/Dropbox/App/reinstallOS/style/GitHub.html")))
 ((eq system-type 'darwin)
  (progn
    (setq markdown-command
          "/usr/local/bin/pandoc -c /Users/haiying/Library/CloudStorage/Dropbox/App/reinstallOS/style/github-pandoc.css --from=markdown -t html5 --highlight-style pygments --standalone --mathjax --quiet --citeproc --template /Users/haiying/Library/CloudStorage/Dropbox/App/reinstallOS/style/GitHub.html")))
 )

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

(provide 'polymode-config)

;;; insert code chunk
;; ;;; https://emacs.stackexchange.com/questions/27405/insert-code-chunk-in-r-markdown-with-yasnippet-and-polymode
;; (defun rmd-insert-r-chunk (header)
;;   "Insert an r-chunk HEADER in markdown mode.
;; Necessary due to interactions between polymode and yas snippet."
;;   (interactive "sHeader: ")
;;   (insert (concat "```{r " header "}\n\n```"))
;;   (forward-line -1))

;; (custom-set-variables
;;  '(markdown-command "/usr/bin/pandoc"))
