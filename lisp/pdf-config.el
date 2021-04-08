;;; pdf-tools, nice but obviously slower than okular
(use-package pdf-tools
  :ensure t
  :config
  ;; (pdf-tools-install)
  (pdf-loader-install)
  ;; trim margin consistently
  (defadvice pdf-view-scroll-up-or-next-page (after re-slice activate)
    (if (pdf-view-current-slice)
        (pdf-view-set-slice-from-bounding-box)))
  (defadvice pdf-view-scroll-down-or-previous-page (after re-slice activate)
    (if (pdf-view-current-slice)
        (pdf-view-set-slice-from-bounding-box)))
  (defadvice pdf-view-next-line-or-next-page (after re-slice activate)
    (if (pdf-view-current-slice)
        (pdf-view-set-slice-from-bounding-box)))
  (defadvice pdf-view-previous-line-or-previous-page (after re-slice activate)
    (if (pdf-view-current-slice)
        (pdf-view-set-slice-from-bounding-box)))
  )

(use-package pdf-view-restore
  :ensure t
  :after pdf-tools
  :config
  (add-hook 'pdf-view-mode-hook 'pdf-view-restore-mode))
(setq pdf-view-restore-filename "~/.emacs.d/.emacs.tmp/.pdf-view-restore")

(provide 'pdf-config)
;;; init.pdf.el ends here

