(setq reftex-plug-into-auctex t)
(setq preview-scale-function 1.5)
;; (setq TeX-auto-save nil)
(setq TeX-auto-save t)
(setq TeX-PDF-mode t)
(setq TeX-save-query  nil)
(setq bibtex-align-at-equal-sign t)
(setq TeX-source-correlate-mode t)
;; Alternative 3: Use the external wmctrl tool in order to
;; force Emacs into the focus.
(setq TeX-raise-frame-function
      (lambda ()
	(call-process
	 "wmctrl" nil nil nil "-i" "-R"
	 (frame-parameter (selected-frame) 'outer-window-id))))

(defun my-LaTeX-hook ()
  (local-set-key (kbd "C-c C-f") 'tex-frame)
  (local-set-key (kbd "$") 'insert-dollor-sign)
  (setq TeX-parse-self t)
  (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)
  (tex-fold-mode t)
  (flyspell-mode t)
  (LaTeX-math-mode t)
  (visual-line-mode t)
  (flyspell-mode t)
  ;; (outline-minor-mode t)
  )
(defun insert-dollor-sign ()
  (interactive)
  (insert "$$")
  (backward-char 1))
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

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;; (add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'my-LaTeX-hook)

(provide 'latex-config)

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

;; (require 'flymake)
;; (defun flymake-get-tex-args (file-name)
;; (list "pdflatex"
;; (list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))


;; ;; using auctex
;; (use-package tex
;;   :ensure auctex)

;; ;; Turn on RefTeX in AUCTeX
;; (add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;; ;; Activate nice interface between RefTeX and AUCTeX
;; (setq reftex-plug-into-AUCTeX t)

;; ;;; add company backend for latex math
;; (use-package company-math
;;   :ensure t)
;; (eval-after-load 'company
;;   '(add-to-list 'company-backends 'company-math-symbols-unicode))

;; ;;; using ivy-bibtex
;; (use-package ivy-bibtex
;;   :ensure t)
;; (global-set-key (kbd "M-s b") 'ivy-bibtex)

;; (setq bibtex-completion-bibliography
;;       '("~/bibrary/bib/index.bib"))
;; (setq bibtex-completion-library-path
;;       '("~/bibrary/papers"
;;         "~/bibrary/books"
;;         "~/bibrary/misc"))

;; ;;; I do not use notes anyway
;; ;; (setq bibtex-completion-notes-path
;; ;;       "~/bibrary/notes.org")
;; (setq bibtex-completion-notes-path nil)
;; (setq bibtex-completion-pdf-field nil)
;; (setq bibtex-completion-find-additional-pdfs t)
;; (setq bibtex-completion-pdf-extension '(".pdf" ".djvu"))
;; (unless *is-a-mac*
;;   (setq bibtex-completion-pdf-open-function
;;         (lambda (fpath)
;;           (call-process "okular" nil 0 nil fpath))))

;; ;;; using gsholar-bibtex
;; (use-package gscholar-bibtex
;;   :ensure t)

;; ;;; auto run bib-validate-globally whenever saving bibtex files
;; (defun bibtex-auto-validate-globally ()
;;   "Run bibtex-validate-globally after saving the bibtex files."
;;   (when (eq major-mode 'bibtex-mode)
;;     (bibtex-validate-globally)))
;; (add-hook 'after-save-hook #'bibtex-auto-validate-globally)

