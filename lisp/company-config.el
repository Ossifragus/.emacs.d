;; pkg: company
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

(provide 'company-config)

;; ;; pkg: company
;; (use-package company
;;   :ensure t
;;   :init
;;   (add-hook 'after-init-hook 'global-company-mode)
;;   :config
;;   (define-key company-mode-map (kbd "M-/") 'company-complete)
;;   (define-key company-active-map (kbd "M-/") 'company-other-backend)
;;   (define-key company-active-map (kbd "C-n") 'company-select-next)
;;   (define-key company-active-map (kbd "C-p") 'company-select-previous)
;;   (setq-default company-dabbrev-other-buffers 'all
;;                 company-tooltip-align-annotations t)
;;   (global-set-key (kbd "M-C-/") 'company-complete)
;;   (setq tab-always-indent 'complete)
;;   (add-to-list 'completion-styles 'initials t)
;;   )
