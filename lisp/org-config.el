(require 'org)
(require 'oc-csl)
;; (use-package ox-reveal
;;   :ensure t
;;   :config
;;   (require 'ox-reveal)
;; 	)

(use-package org-re-reveal
  :ensure t
  :config
  (require 'org-re-reveal)
	)

;; (require 'ox-reveal)
;; (require 'org-ref)
(add-to-list 'auto-mode-alist '("\\.org.txt" . org-mode))
;; (setq org-re-reveal-root "file:///home/ossifragus/Dropbox/mydoc/reinstallOS/reveal.js")

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

;; ;; https://zzamboni.org/post/how-to-easily-create-and-use-human-readable-ids-in-org-mode-and-doom-emacs/
;; (require 'org-id)
;; (use-package counsel
;;   :ensure t
;;   :config
;;   (require 'counsel)
;; 	)

(eval-after-load 'counsel
	'(add-hook 'org-mode-hook
						 (lambda () (define-key org-mode-map
													(kbd "C-c )") #'counsel-org-link))))

;; (setq counsel-outline-display-style 'title)
;; (setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)
;; (defun zz/make-id-for-title (title)
;;   "Return an ID based on TITLE."
;;   (let* ((new-id (replace-regexp-in-string "[^[:alnum:]]" "-" (downcase title))))
;;     new-id))
;; (defun zz/org-custom-id-create ()
;;   "Create and store CUSTOM_ID for current heading."
;;   (let* ((title (or (nth 4 (org-heading-components)) ""))
;;          (new-id (zz/make-id-for-title title)))
;;     (org-entry-put nil "CUSTOM_ID" new-id)
;;     (org-id-add-location new-id (buffer-file-name (buffer-base-buffer)))
;;     new-id))

;; (defun zz/org-custom-id-get-create (&optional where force)
;;   "Get or create CUSTOM_ID for heading at WHERE. If FORCE is t, always recreate the property."
;; 	(org-with-point-at where
;;     (let ((old-id (org-entry-get nil "CUSTOM_ID")))
;;       ;; If CUSTOM_ID exists and FORCE is false, return it
;;       (if (and (not force) old-id (stringp old-id))
;;           old-id
;;         ;; otherwise, create it
;;         (zz/org-custom-id-create)))))

;; ;; Now override counsel-org-link-action
;; ;; (after! counsel
;; (defun counsel-org-link-action (x)
;; 	"Insert a link to X. X is expected to be a cons of the form (title . point), as passed by `counsel-org-link'. If X does not have a CUSTOM_ID, create it based on the headline title."
;; 	(let* ((id (zz/org-custom-id-get-create (cdr x))))
;; 		(org-insert-link nil (concat "#" id) (car x))))
;; ;; )

(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))

;; publishing
;; (setq org-publish-project-alist
;;       '(
;; 				;; ... add all the components here (see below)...
;; 				("org-myweb"
;; 				 :base-directory "~/Dropbox/mydoc/web/"
;; 				 :base-extension "org"
;; 				 :publishing-directory "~/Dropbox/mydoc/web/"
;; 				 :exclude "\\(?:\\(?:style/o\\)?thers\\)"
;;          :exclude (regexp-opt '("others" "style/others"))
;; 				 :recursive t
;; 				 :publishing-function publish-html-and-patch
;; 				 )
;;       ))

(defvar OS--publish-project-alist
  (list
   (list "myweb"
				 :base-directory "~/Dropbox/mydoc/web/"
				 :base-extension "org"
				 :publishing-directory "~/Dropbox/mydoc/web/"
         :exclude (regexp-opt '("others" "style/others"))
         :recursive t
         :publishing-function 'publish-html-and-patch)
   ;; (list "attachments"
   ;;       :base-directory "./"
   ;;       :exclude (regexp-opt '("assets" "public"))
   ;;       ;; :include '("CNAME" "keybase.txt" "LICENSE" ".nojekyll" "publish.el")
   ;;       :recursive t
   ;;       :base-extension (regexp-opt '("jpg" "gif" "png" "svg" "css" "pdf"))
   ;;       :publishing-directory "./public"
   ;;       :publishing-function 'org-publish-attachment)
	 ))

(setq org-publish-project-alist OS--publish-project-alist)

(defun publish-html-and-patch (plist filename pub-dir)
	"Export a html file then patch it by reversing lines"
	(let ((outfile (org-html-publish-to-html plist filename pub-dir)))
		(shell-command (format "sed -i 's/Wang, H\\./<strong>Wang, H.<\\/strong>/' %s"
													 outfile
													 (file-name-sans-extension outfile))
									 )))

(with-eval-after-load 'ox-latex
   (add-to-list 'org-latex-classes
                '("ltxdoc"
                  "\\documentclass{ltxdoc}"
									("\\section{%s}" . "\\section*{%s}")
									("\\subsection{%s}" . "\\subsection*{%s}")
									("\\subsubsection{%s}" . "\\subsubsection*{%s}")
									("\\paragraph{%s}" . "\\paragraph*{%s}")
									("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(add-hook 'org-mode-hook 'turn-on-auto-fill)

(use-package org-unique-id
  :ensure t
  :config
  (require 'org-unique-id)
    ;; :init
    ;; (add-hook 'org-mode-hook
    ;;    (lambda ()
    ;;      (add-hook 'before-save-hook
    ;;                (lambda ()
    ;;                  (when (and (eq major-mode       'org-mode)
    ;;                             (eq buffer-read-only nil))
    ;;                    (org-unique-id))))))
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
