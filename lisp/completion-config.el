;;;;;;;;; IDO
(setq ido-enable-flex-matching t) ;; enable fuzzy matchings
;; (setq ido-everywhere t)
(setq ido-ignore-files '("\.synctex.gz" "\.bst"))
(setq ido-save-directory-list-file "~/.emacs.d/var/ido.last")
(ido-mode 1)
(global-set-key (kbd "C-x C-f") 'ido-find-file)

;; (use-package smex
;;   :ensure t)

(use-package vertico
  :ensure t
  ;; :custom
  ;; (vertico-scroll-margin 0) ;; Different scroll margin
  ;; (vertico-count 20) ;; Show more candidates
  ;; (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  ;; (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (vertico-mode))
;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :ensure t
  :init
  (savehist-mode))

;; Emacs minibuffer configurations.
(use-package emacs
  :custom
  ;; Enable context menu. `vertico-multiform-mode' adds a menu in the minibuffer
  ;; to switch display modes.
  (context-menu-mode t)
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :ensure t
  ;; :init (icomplete-mode)
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil) ;; Disable defaults, use our settings
  ;; (completion-pcm-leading-wildcard t) ;; Emacs 31: partial-completion behaves like substring
  )

;; (use-package ivy
;;   :ensure t
;;   :config
;;   (ivy-mode 1)
;;   )
;; (use-package counsel
;;   :ensure t
;;   :config
;;   (counsel-mode 1)
;;   )

;; (setq ivy-re-builders-alist '((swiper . ivy--regex-plus)
;;                               ;; (t . ivy--regex-fuzzy)
;;                               ))
;; (setq counsel-find-file-ignore-regexp "\\..synctex.gz\\'\\|\\.bst\\'")

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  ;; :config
  ;; (define-key company-mode-map (kbd "M-/") 'company-complete)
  ;; (define-key company-active-map (kbd "M-/") 'company-other-backend)
  ;; (define-key company-active-map (kbd "C-n") 'company-select-next)
  ;; (define-key company-active-map (kbd "C-p") 'company-select-previous)
  ;; (setq-default company-dabbrev-other-buffers 'all
  ;;               company-tooltip-align-annotations t)
  ;; (global-set-key (kbd "M-C-/") 'company-complete)
  ;; (setq tab-always-indent 'complete)
  ;; (add-to-list 'completion-styles 'initials t)
  )

(use-package company-math
  :ensure t)

(use-package company-emoji
  :ensure t)

(defun setup-unicode ()
  "Unicode input for the buffer."
  (interactive)
  (company-mode)                        ; using company-mode
  (setq-local company-backends '(company-emoji company-math-symbols-unicode))
  (setq-local company-minimum-prefix-length 1)
  (setq-local company-idle-delay 0))

(provide 'completion-config)

