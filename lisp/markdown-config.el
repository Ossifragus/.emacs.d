;;; markdown-config.el -*- lexical-binding: t; -*-

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

(use-package pandoc-mode
  :ensure t
  :hook ((markdown-mode . pandoc-mode)
         (pandoc-mode   . my-pandoc-mode-setup))
  :init
  (setq pandoc-use-async t
        pandoc-process-connection-type nil
        pandoc-pdf-viewer #'my-pandoc-view-pdf)
  :config
  (add-hook 'pandoc-async-success-hook #'my-pandoc--maybe-view-after-async)
  (with-eval-after-load 'evil
    (evil-define-key '(normal visual) markdown-mode-map
      (kbd "<leader>cp") #'my-pandoc-export-pdf
      (kbd "<leader>ca") #'my-pandoc-pdf-and-view
      (kbd "<leader>cv") #'pandoc-view-output
      (kbd "<leader>cc") #'pandoc-main-transient)))

(defvar my-pandoc--view-after-async-buffer nil
  "Buffer whose PDF output should be opened after an async Pandoc run.")

(defun my-pandoc-mode-setup ()
  "Configure default PDF export settings for `pandoc-mode'."
  (unless (pandoc--load-settings-profile "default" 'no-confirm)
    (pandoc--set 'write "latex")
    (pandoc--set 'pdf-engine "xelatex")
    (setq pandoc--settings-modified-flag nil)))

(defun my-pandoc--maybe-view-after-async ()
  "Open the generated PDF when requested by `my-pandoc-pdf-and-view'."
  (when (buffer-live-p my-pandoc--view-after-async-buffer)
    (let ((buf my-pandoc--view-after-async-buffer))
      (setq my-pandoc--view-after-async-buffer nil)
      (with-current-buffer buf
        (pandoc-view-output)))))

(defun my-pandoc-export-pdf (&optional prefix)
  "Save the current Markdown buffer and convert it to PDF via `pandoc-mode'."
  (interactive "P")
  (unless (bound-and-true-p pandoc-mode)
    (pandoc-mode 1))
  (when (and (buffer-file-name) (buffer-modified-p))
    (save-buffer))
  (setq my-pandoc--view-after-async-buffer nil)
  (pandoc-convert-to-pdf prefix))

(defun my-pandoc-pdf-and-view (&optional prefix)
  "Save the current Markdown buffer, convert it to PDF, and open the viewer."
  (interactive "P")
  (unless (bound-and-true-p pandoc-mode)
    (pandoc-mode 1))
  (when (and (buffer-file-name) (buffer-modified-p))
    (save-buffer))
  (if pandoc-use-async
      (progn
        (setq my-pandoc--view-after-async-buffer (current-buffer))
        (pandoc-convert-to-pdf prefix))
    (setq my-pandoc--view-after-async-buffer nil)
    (pandoc-convert-to-pdf prefix)
    (pandoc-view-output)))

(defun my-pandoc-view-pdf (pdf-file)
  "Open PDF-FILE in Okular (Linux) or Skim (macOS)."
  (let ((pdf-file (expand-file-name pdf-file)))
    (cond
     ((eq system-type 'gnu/linux)
      (let ((instance (and (fboundp 'my-TeX-okular--find-instance)
                           (my-TeX-okular--find-instance pdf-file))))
        (if instance
            (condition-case nil
                (progn
                  (dbus-call-method
                   :session (car instance) (cdr instance)
                   "org.kde.okular" "openDocument"
                   (concat "file:" pdf-file))
                  (ignore-errors
                    (dbus-call-method
                     :session (car instance) "/okularshell"
                     "org.kde.okular" "tryRaise" "")))
              (error
               (start-process "okular" nil "okular" pdf-file)))
          (start-process "okular" nil (if (executable-find "okular") "okular" "xdg-open") pdf-file))))
     ((eq system-type 'darwin)
      (if (file-directory-p "/Applications/Skim.app")
          (start-process "skim" nil "open" "-a" "Skim" pdf-file)
        (start-process "open" nil "open" pdf-file)))
     (t
      (find-file-other-window pdf-file)))))

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

(provide 'markdown-config)
;;; markdown-config.el ends here
