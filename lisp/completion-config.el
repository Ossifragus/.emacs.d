;;;;;;;;; IDO
;; (require 'ido)
;; (ido-mode t)
;; (setq ido-enable-flex-matching t) ;; enable fuzzy matchings
(setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)
(setq ido-ignore-files '("\.synctex.gz" "\.bst"))
(setq ido-save-directory-list-file "~/.emacs.d/var/ido.last")
(ido-mode 1)
(global-set-key (kbd "C-x C-f") 'ido-find-file)

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
                              (t . ivy--regex-fuzzy)))
;; (setq counsel-find-file-ignore-regexp "\\..synctex.gz\\'\\|\\.bst\\'")

(provide 'completion-config)

