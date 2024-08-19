;; https://github.com/jorgenschaefer/elpy/issues/1729
;; M-x elpy-rpc-reinstall-virtualenv
;; pipx install virtualenv
(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  :config
  (setq elpy-shell-display-buffer-after-send 1)
  )

;; https://emacs.stackexchange.com/questions/47358/can-t-guess-python-indent-offset-delete-warning-when-local-file-variable
(setq python-indent-guess-indent-offset-verbose nil)

(defun elpy-shell-send-statement ()
  "Send current or next statement to Python shell and step.

If the current line is part of a statement, sends this statement.
Otherwise, skips forward to the next code line and sends the
corresponding statement."
  (interactive)
  (elpy-shell--ensure-shell-running)
  (elpy-shell--nav-beginning-of-statement)
  ;; Make sure there is a statement to send
  (unless (looking-at "[[:space:]]*$")
    (unless elpy-shell-echo-input (elpy-shell--append-to-shell-output "\n"))
    (let ((beg (save-excursion (beginning-of-line) (point)))
          (end (progn (elpy-shell--nav-end-of-statement) (point))))
      (unless (eq beg end)
        (elpy-shell--flash-and-message-region beg end)
        (elpy-shell--add-to-shell-history (buffer-substring beg end))
        (elpy-shell--with-maybe-echo
         (python-shell-send-string
          (python-shell-buffer-substring beg end)))))
    ))


(defun my-python-hook ()
  (local-set-key (kbd "C-c C-j") 'elpy-shell-send-statement)
  ;; (auto-highlight-symbol-mode t)
  (display-line-numbers-mode t)
  (highlight-indentation-mode t)
  (hs-minor-mode t)
  (highlight-numbers-mode t))
(add-hook 'python-mode-hook 'my-python-hook)

(use-package conda
  :ensure t
  :config
  (require 'conda)
  ;; ;; if you want interactive shell support, include:
  ;; (conda-env-initialize-interactive-shells)
  ;; ;; if you want eshell support, include:
  ;; (conda-env-initialize-eshell)
  ;; ;; if you want auto-activation (see below for details), include:
  ;; (conda-env-autoactivate-mode t)
  ;; ;; if you want to automatically activate a conda environment on the opening of a file:
  ;; (add-hook 'find-file-hook (lambda () (when (bound-and-true-p conda-project-env-path)
  ;;                                        (conda-env-activate-for-buffer))))
  )


(provide 'python-config)
