(require 'org)
;; (require 'ox-md)
;; (require 'org-ref)
(add-to-list 'auto-mode-alist '("\\.org.txt" . org-mode))

;; (setq org-todo-keywords
;;       '((sequence "TODO" "DOING" "NEED-INFO" "FEEDBACK" "|" "DONE")))

(setq org-todo-keywords
      '(
        (sequence "IDEA(i)" "TODO(t)" "STARTED(s)" "FEEDBACK(f)" "WAITING(w)" "|" "DONE(d)")
        (sequence "|" "CANCELED(c)" ) ;; "DELEGATED(l)" "SOMEDAY(f)"
        ))

(setq org-todo-keyword-faces
      '(("IDEA" . (:foreground "GoldenRod" :weight bold))
        ("FEEDBACK" . (:foreground "IndianRed1" :weight bold))
        ("STARTED" . (:foreground "OrangeRed" :weight bold))
        ("WAITING" . (:foreground "coral" :weight bold))
        ("CANCELED" . (:foreground "LimeGreen" :weight bold))
        ;; ("DELEGATED" . (:foreground "LimeGreen" :weight bold))
        ;; ("SOMEDAY" . (:foreground "LimeGreen" :weight bold))
        ))

(eval-after-load 'org
  '(progn
     ;; toggle C-TAB (org-force-cycle-archived) in org-mode
		 (require 'ox-gfm nil t)
     (define-key org-mode-map [C-tab] nil)
		 (setf org-highlight-latex-and-related '(latex))
     ;; (define-key org-mode-map (kbd "C-c l") 'org-store-link)
     ;; (define-key org-mode-map (kbd "C-c a") 'org-agenda)
     ;; (define-key org-mode-map (kbd "C-c c") 'org-capture)
     ;; (define-key org-mode-map (kbd "C-c b") 'org-iswitchb)
     ;; (define-key org-mode-map (kbd "M-q") 'org-fill-paragraph)
     (org-babel-do-load-languages
      'org-babel-load-languages
      '((R . t)
        ;; (C . t)
        ;; (dot . t)
        (emacs-lisp . t)
        (gnuplot . t)
        (julia-vterm . t)
        (latex . t)
        (python . t)
        ;; (awk . t)
        ;; (css . t)
        ;; (js . t)
        ;; (lisp . t)
        (org . t)
        (shell . t)
        ;; (sed . t)
        ;; (sql . t)
        ;; (sqlite . t)
        ))))
(defalias 'org-babel-execute:julia 'org-babel-execute:julia-vterm)
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

;; various preferences
(setq
 ;; org-catch-invisible-edits 'show
 org-confirm-babel-evaluate nil
 ;; org-edit-timestamp-down-means-later t
 ;; org-export-coding-system 'utf-8
 ;; org-export-kill-product-buffer-when-displayed t
 ;; org-export-latex-default-packages-alist nil
 ;; org-fast-tag-selection-single-key 'expert
 org-hide-emphasis-markers t
 ;; ;; org-html-htmlize-output-type 'css
org-html-validation-link nil
 org-latex-listings 'minted
 org-latex-packages-alist '(("" "minted"))
 ;; org-latex-pdf-process '("lualatex -halt-on-error -shell-escape -pdf %f")
 org-latex-pdf-process
 '("lualatex -shell-escape -interaction nonstopmode -output-directory %o %f"
   "lualatex -shell-escape -interaction nonstopmode -output-directory %o %f"
   ;; "lualatex -shell-escape -interaction nonstopmode -output-directory %o %f"
	 )
 org-edit-src-content-indentation 0
 org-src-tab-acts-natively t
 org-src-preserve-indentation t
 ;; org-log-done t
 ;; org-reverse-note-order t
 org-src-fontify-natively t
 ;; org-tags-column 80
 )

(provide 'org-config)

;; (setq org-latex-minted-options
;; 			'(("breaklines" "true")
;; 				("breakanywhere" "true")
;; 				("fontsize" "\\footnotesize")
;; 				;; ("linenos")
;; 				("frame" "single")
;; 				))

;; ;; pkg: org-mode
;; (require 'org)
;; (require 'ox)
;; (require 'ox-html)
;; (require 'ox-latex)

;; (use-package htmlize
;;   :ensure t)

;; (eval-after-load 'org
;;   '(progn
;;      ;; toggle C-TAB (org-force-cycle-archived) in org-mode
;;      (define-key org-mode-map [C-tab] nil)
;;      (define-key org-mode-map (kbd "C-c l") 'org-store-link)
;;      (define-key org-mode-map (kbd "C-c a") 'org-agenda)
;;      (define-key org-mode-map (kbd "C-c c") 'org-capture)
;;      (define-key org-mode-map (kbd "C-c b") 'org-iswitchb)
;;      (define-key org-mode-map (kbd "M-q") 'org-fill-paragraph)
;;      (org-babel-do-load-languages
;;       'org-babel-load-languages
;;       '((R . t)
;;         (C . t)
;;         (dot . t)
;;         (emacs-lisp . t)
;;         (gnuplot . t)
;;         (latex . t)
;;         (python . t)
;;         (awk . t)
;;         (css . t)
;;         (js . t)
;;         (lisp . t)
;;         (org . t)
;;         (shell . t)
;;         (sed . t)
;;         (sql . t)
;;         (sqlite . t)
;;         ))))

;; ;; various preferences
;; (setq
;;  org-catch-invisible-edits 'show
;;  org-confirm-babel-evaluate nil
;;  org-edit-timestamp-down-means-later t
;;  org-export-coding-system 'utf-8
;;  org-export-kill-product-buffer-when-displayed t
;;  org-export-latex-default-packages-alist nil
;;  org-fast-tag-selection-single-key 'expert
;;  org-hide-emphasis-markers t
;;  ;; org-html-htmlize-output-type 'css
;;  org-html-validation-link nil
;;  org-latex-listings 'minted
;;  org-latex-packages-alist '(("" "minted"))
;;  org-latex-pdf-process '("latexmk -halt-on-error -shell-escape -pdf %f")
;;  org-log-done t
;;  org-reverse-note-order t
;;  org-src-fontify-natively t
;;  org-tags-column 80
;;  )
