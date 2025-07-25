;;;;;;;;; IDO
(setq ido-enable-flex-matching t) ;; enable fuzzy matchings
;; (setq ido-everywhere t)
(setq ido-ignore-files '("\.synctex.gz" "\.bst"))
(setq ido-save-directory-list-file "~/.emacs.d/var/ido.last")
(ido-mode 1)
(global-set-key (kbd "C-x C-f") 'ido-find-file)

;; (use-package smex
;;   :ensure t)

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  )
(use-package counsel
  :ensure t
  :config
  (counsel-mode 1)
  )

(setq ivy-re-builders-alist '((swiper . ivy--regex-plus)
                              ;; (t . ivy--regex-fuzzy)
                              ))
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

