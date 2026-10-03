;;; org-config.el -*- lexical-binding: t; -*-

(use-package org
  :ensure nil
  :bind (("C-c a" . org-agenda))
  :hook ((org-mode . auto-fill-mode))
  :init
  (setq org-startup-numerated t
        org-highlight-latex-and-related '(latex)
        org-format-latex-options (plist-put org-format-latex-options :scale 2.0)
        org-agenda-files '("~/Dropbox/mydoc/agenda.org"
                           "~/Dropbox/mydoc/notes.org")
        org-safe-remote-resources '("\\`https://fniessen\\.github\\.io\\(?:/\\'\\)")
        org-confirm-babel-evaluate nil
        org-time-stamp-rounding-minutes '(0 1)
        org-hide-emphasis-markers t
        org-html-validation-link nil
        org-latex-listings 'minted
        org-latex-packages-alist '(("" "minted"))
        org-latex-pdf-process
        '("lualatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "lualatex -shell-escape -interaction nonstopmode -output-directory %o %f")
        org-edit-src-content-indentation 0
        org-src-tab-acts-natively t
        org-src-preserve-indentation t
        org-src-fontify-natively t)

  (setq org-todo-keywords
        '((sequence "IDEA(i)" "TODO(t)" "STARTED(s)" "FEEDBACK(f)" "WAITING(w)" "|" "DONE(d)")
          (sequence "|" "CANCELED(c)" "REJECTED(r)")))

  (setq org-todo-keyword-faces
        '(("IDEA"     . (:foreground "GoldenRod"  :weight bold))
          ("FEEDBACK" . (:foreground "IndianRed1" :weight bold))
          ("STARTED"  . (:foreground "OrangeRed"  :weight bold))
          ("WAITING"  . (:foreground "coral"      :weight bold))
          ("CANCELED" . (:foreground "LimeGreen"  :weight bold))
          ("REJECTED" . (:foreground "firebrick"  :weight bold))))

  (add-to-list 'auto-mode-alist '("\\.org\\.txt\\'" . org-mode))

  :config
  ;; Disable C-tab in org-mode-map so window/tab switching isn't intercepted
  (define-key org-mode-map [C-tab] nil)

  ;; Load Babel languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((R          . t)
     (emacs-lisp . t)
     (gnuplot    . t)
     (julia      . t)
     (latex      . t)
     (python     . t)
     (org        . t)
     (shell      . t)))

  ;; Evil-mode TAB binding for org-mode
  (with-eval-after-load 'evil
    (evil-define-key 'normal org-mode-map (kbd "TAB")   #'org-cycle)
    (evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle)))

;; Citation & Export Plugins
(use-package oc-csl
  :after org
  :init
  (setq org-cite-csl-styles-dir (expand-file-name "~/Dropbox/mydoc/web/style/"))
  (with-eval-after-load 'oc
    (setq org-cite-activate-processor nil)))

(use-package ox-ipynb
  :after org)

(use-package ox-pandoc
  :ensure t
  :after org)

(use-package org-modern
  :ensure t
  :defer t)

(use-package citeproc
  :ensure t
  :defer t)

(use-package poly-org
  :ensure t)

(use-package org-re-reveal
  :ensure t
  :defer t)

(use-package org-appear
  :ensure t
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autolinks t
        org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autoentities t))

(use-package org-unique-id
  :ensure t)

;; ;;; Publishing Configuration

;; (defun publish-html-and-patch (plist filename pub-dir)
;;   "Export a HTML file then bold the author name 'Wang, H.'."
;;   (let ((outfile (org-html-publish-to-html plist filename pub-dir)))
;;     (when (file-exists-p outfile)
;;       (with-temp-file outfile
;;         (insert-file-contents outfile)
;;         (goto-char (point-min))
;;         (while (search-forward "Wang, H." nil t)
;;           (replace-match "<strong>Wang, H.</strong>" t t))))
;;     outfile))

;; (setq org-publish-project-alist
;;       `(("myweb"
;;          :base-directory "~/Dropbox/mydoc/web/"
;;          :base-extension "org"
;;          :publishing-directory "~/Dropbox/mydoc/web/"
;;          :exclude ,(regexp-opt '("others" "style/others"))
;;          :recursive t
;;          :publishing-function publish-html-and-patch)))

;; (with-eval-after-load 'ox-latex
;;   (add-to-list 'org-latex-classes
;;                '("ltxdoc"
;;                  "\\documentclass{ltxdoc}"
;;                  ("\\section{%s}"       . "\\section*{%s}")
;;                  ("\\subsection{%s}"    . "\\subsection*{%s}")
;;                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;                  ("\\paragraph{%s}"     . "\\paragraph*{%s}")
;;                  ("\\subparagraph{%s}"  . "\\subparagraph*{%s}"))))

(provide 'org-config)
;;; org-config.el ends here
