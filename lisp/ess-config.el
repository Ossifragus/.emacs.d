(use-package ess
  :ensure t
  :config
  (setq ess-swv-plug-into-AUCTeX-p t)
  (setq ess-ask-for-ess-directory nil)
  (setq comint-scroll-to-bottom-on-input t)
  (setq comint-scroll-to-bottom-on-output t)
  (setq comint-move-point-for-output t)
  ;; (setq ess-eval-visibly-p nil)
  ;; (add-to-list 'load-path "~/Dropbox/.Emacs/ess-18.10.2/lisp")
  ;; (require 'ess-site)
  (require 'ess-r-mode)
  (ess-toggle-underscore nil)
  ;; (setq ess-long+replacement "")
  (setq ess-R-font-lock-keywords
	'((ess-R-fl-keyword:keywords . t)
          (ess-R-fl-keyword:constants  . t)
          (ess-R-fl-keyword:modifiers  . t)
          (ess-R-fl-keyword:fun-defs   . t)
          (ess-R-fl-keyword:assign-ops . t)
          (ess-fl-keyword:fun-calls . t)
          (ess-fl-keyword:numbers)
          (ess-fl-keyword:operators . t)
          (ess-fl-keyword:delimiters)
          (ess-fl-keyword:= . t)
          (ess-R-fl-keyword:F&T . t)))
  (setq inferior-R-font-lock-keywords
	'(;; comint is bad at prompt highlighting
	  (ess-S-fl-keyword:prompt . t)
          (ess-R-fl-keyword:keywords . t)
          (ess-R-fl-keyword:constants . t)
          (ess-R-fl-keyword:modifiers . t)
          (ess-R-fl-keyword:messages . t)
          (ess-R-fl-keyword:fun-defs . t)
          (ess-R-fl-keyword:assign-ops . t)
          (ess-fl-keyword:matrix-labels . t)
          (ess-fl-keyword:fun-calls . t)
          (ess-fl-keyword:numbers)
          (ess-fl-keyword:operators . t)
          (ess-fl-keyword:delimiters)
          (ess-fl-keyword:= . t)
          (ess-R-fl-keyword:F&T . t)))
  (setq ess-R-font-lock-keywords
	'((ess-R-fl-keyword:keywords . t)
          (ess-R-fl-keyword:constants  . t)
          (ess-R-fl-keyword:modifiers  . t)
          (ess-R-fl-keyword:fun-defs   . t)
          (ess-R-fl-keyword:assign-ops . t)
          (ess-fl-keyword:fun-calls . t)
          (ess-fl-keyword:numbers)
          (ess-fl-keyword:operators . t)
          (ess-fl-keyword:delimiters)
          (ess-fl-keyword:= . t)
          (ess-R-fl-keyword:F&T . t)))
  (setq inferior-R-font-lock-keywords
	'(;; comint is bad at prompt highlighting
	  (ess-S-fl-keyword:prompt . t)
          (ess-R-fl-keyword:keywords . t)
          (ess-R-fl-keyword:constants . t)
          (ess-R-fl-keyword:modifiers . t)
          (ess-R-fl-keyword:messages . t)
          (ess-R-fl-keyword:fun-defs . t)
          (ess-R-fl-keyword:assign-ops . t)
          (ess-fl-keyword:matrix-labels . t)
          (ess-fl-keyword:fun-calls . t)
          (ess-fl-keyword:numbers)
          (ess-fl-keyword:operators . t)
          (ess-fl-keyword:delimiters)
          (ess-fl-keyword:= . t)
          (ess-R-fl-keyword:F&T . t)))
  ;; (require 'ess-site)
  ;; ;; Turn off smart underscore in ESS
  ;; (setq ess-smart-S-assign-key nil)
  ;; ;; ;; ESS Mode (.R file)
  ;; (setq ess-eval-visibly 'nowait)
  ;; (setq ess-history-file nil)
  ;; (setq inferior-R-args "--no-save --no-restore --no-site-file --no-environ")
  ;; :bind (
  ;; 	 :map ess-mode-map
  ;; 	      ("C-r" . ess-eval-function-or-paragraph-and-step)
  ;; 	      ("C-c M-." . find-tag)	; also use `find-tag' from etags.el
  ;; 	      ("M--" . " <- ")
  ;; 	      ("M-0 M--" . nil)
  ;;        :map inferior-ess-mode-map
  ;; 	      ("M--" . " <- ")
  ;; 	      ("M-0 M--" . nil)
  ;; 	 )
  )

;; ;;; disable flymake and flycheck for ess
;; (add-hook 'ess-mode-hook
;;           (lambda ()
;;             (setq ess-use-flymake nil)
;;             (ess-set-style 'RRR)
;;             (setq ess-align-nested-calls nil) ; please indent ifelse as usual
;;             (setq flycheck-disabled-checkers '(r-lintr))))

;; (add-hook 'ess-r-post-run-hook
;;           (lambda ()
;;             (setq patch-essr-dir (expand-file-name "R" user-emacs-directory))
;;             (ess-command (format "source('%s/patch_essr.R')" patch-essr-dir))
;;             ))

;; ;;; enable etags backend in addition to ess-r-xref-backend
;; ;;; modified from Pan Xie's example at https://www.emacswiki.org/emacs/TagsFile
;; (when (require 'xref nil t)
;;   (defun xref--find-xrefs (input kind arg display-action)
;;     "Re-define the `xref--find-xrefs'.
;;  This is a re-defined version of `xref--find-xrefs'.  This
;;  function will call all backends until the definitions are found
;;  or the `xref-backend-functions' is exhausted."
;;     (let ((fn (intern (format "xref-backend-%s" kind)))
;;           (tail xref-backend-functions))
;;       (cl-block nil
;;         (while tail
;;           (let* ((backend-fn (car tail))
;;                  (backend (and (symbol-function backend-fn) (funcall backend-fn)))
;;                  (xrefs (and backend (funcall fn backend arg))))
;;             (when xrefs
;;               (cl-return (xref--show-xrefs xrefs display-action))))
;;           (setq tail (cdr tail)))
;;         (user-error "No %s found for: %s" (symbol-name kind) input)))))

;; ;; add a hook function to the `ess-mode-hook':
;; (defun hook:ess-mode ()
;;   "Hook for ess-mode."
;;   (when (require 'xref nil t)
;;     (setq-local xref-backend-functions '(etags--xref-backend ess-r-xref-backend t))))
;; (add-hook 'ess-mode-hook 'hook:ess-mode)

;; ;; stan-mode
;; (use-package stan-mode
;;   :ensure t)

(provide 'ess-config)

