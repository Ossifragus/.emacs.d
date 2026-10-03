;;; polymode-config.el -*- lexical-binding: t; -*-

(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'"       . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("README\\.md\\'" . gfm-mode))
  :init
  (setq markdown-header-scaling t
        markdown-fontify-code-blocks-natively t
        markdown-hide-urls t
        markdown-enable-math t)
  :config
  ;; Evil-mode integration: Org-style TAB cycling and outline movement
  (with-eval-after-load 'evil
    (evil-define-key 'normal markdown-mode-map
      (kbd "<tab>") #'markdown-cycle
      (kbd "TAB") #'markdown-cycle
      (kbd "<backtab>") #'markdown-shifttab
      (kbd "S-TAB") #'markdown-shifttab
      (kbd "M-<left>") #'markdown-promote
      (kbd "M-<right>") #'markdown-demote
      (kbd "M-<up>") #'markdown-move-up
      (kbd "M-<down>") #'markdown-move-down))

  :bind (:map markdown-mode-map
         ("<tab>" . markdown-cycle)
         ("<backtab>" . markdown-shifttab)
         ("M-<left>" . markdown-promote)
         ("M-<right>" . markdown-demote)
         ("M-<up>" . markdown-move-up)
         ("M-<down>" . markdown-move-down)))

(use-package polymode
  :ensure t)

(use-package poly-markdown
  :ensure t
  :defer t)

(use-package poly-R
  :ensure t
  :defer t)

(use-package poly-noweb
  :ensure t
  :defer t)

(use-package quarto-mode
  :ensure t
  :defer t)

(add-to-list 'auto-mode-alist '("\\.Rtex\\'" . poly-noweb+r-mode))

(defun my-markdown-hook ()
  "Custom settings for `markdown-mode'."
  (when (fboundp 'tex-fold-mode)
    (tex-fold-mode 1))
  (flyspell-mode 1)
  (visual-line-mode 1))

(add-hook 'markdown-mode-hook #'my-markdown-hook)

;; Pandoc command settings with verified file paths
(cond
 ((eq system-type 'gnu/linux)
  (let ((css (expand-file-name "~/S/App/reinstallOS/style/github-pandoc.css"))
        (template (expand-file-name "~/S/App/reinstallOS/style/GitHub.html")))
    (setq markdown-command
          (if (and (file-exists-p css) (file-exists-p template))
              (format "pandoc -c %s --from=markdown -t html5 --highlight-style pygments --standalone --mathjax --quiet --citeproc --template %s"
                      (shell-quote-argument css)
                      (shell-quote-argument template))
            "pandoc --from=markdown -t html5 --standalone --mathjax"))))
 ((eq system-type 'darwin)
  (setq markdown-command
        "/usr/local/bin/pandoc --from=markdown -t html5 --standalone --mathjax")))

(provide 'polymode-config)
;;; polymode-config.el ends here
