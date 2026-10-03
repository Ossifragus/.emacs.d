;;; chatgpt-config.el -*- lexical-binding: t; -*-

(use-package chatgpt-shell
  :ensure t
  :init
  ;; Ensure the directory exists before the package tries to write to it
  (let ((dir (expand-file-name "var/shell-maker/" user-emacs-directory)))
    (unless (file-exists-p dir)
      (make-directory dir t)))
  :bind (:map chatgpt-shell-mode-map
         ("C-c C-v" . chatgpt-shell-swap-model))
  :config
  (setq chatgpt-shell-openai-key
        (auth-source-pick-first-password :host "api.openai.com"))
  (setq chatgpt-shell-google-key
        (auth-source-pick-first-password :host "aistudio.google.com"))
  (setq chatgpt-shell-openrouter-key
        (auth-source-pick-first-password :host "openrouter.ai/api/v1"))
  (setq chatgpt-shell-anthropic-key
        (auth-source-pick-first-password :host "api.anthropic.com"))
  (setq chatgpt-shell-model-version "gemini-pro-latest"))

(use-package dall-e-shell
  :ensure t
  :config
  (setq dall-e-shell-openai-key
        (auth-source-pick-first-password :host "api.openai.com"))
  (setq dall-e-shell-image-output-directory "~/Desktop/"))

;; Github Copilot
(use-package copilot
  :ensure t
  :config
  (setq copilot-indent-offset-warning-disable t)
  (setq copilot-max-char-warning-disable t)
  :hook ((julia-mode LaTeX-mode markdown-mode org-mode python-mode text-mode) . copilot-mode)
  :bind (:map copilot-completion-map
         ("<tab>" . copilot-accept-completion)
         ("TAB" . copilot-accept-completion)
         :map copilot-mode-map
         ("C-<next>" . copilot-next-completion)
         ("C-<prior>" . copilot-previous-completion)
         ("C-<right>" . copilot-accept-completion-by-word)
         ("C-<down>" . copilot-accept-completion-by-line)))

(use-package agent-shell
  :ensure t
  :after evil
  :config
  ;; Preferred default agent: 'antigravity or 'codex
  (setq agent-shell-preferred-agent-config '(preselect . codex))

  (setq agent-shell-anthropic-authentication
        (agent-shell-anthropic-make-authentication
         :api-key (lambda () (auth-source-pick-first-password :host "api.anthropic.com"))))

  ;; Evil state-specific RET behavior: insert mode=newline, normal mode=send
  (evil-define-key 'insert agent-shell-mode-map (kbd "RET") #'newline)
  (evil-define-key 'normal agent-shell-mode-map (kbd "RET") #'comint-send-input)

  ;; Configure *agent-shell-diff* buffers to start in Emacs state
  (add-hook 'diff-mode-hook
            (lambda ()
              (when (string-match-p "\\*agent-shell-diff\\*" (buffer-name))
                (evil-emacs-state)))))

;; Top-level definition for Emacs 31 to prevent byte-compile warnings
(defvar-local agent-recall-transcript-mode--set-explicitly nil)

(use-package agent-recall
  :ensure t
  :hook (agent-shell-mode . agent-recall-track-sessions)
  :config
  (setq agent-recall-search-paths '("~/Dropbox" "~/S" "~/.emacs.d"))
  (global-agent-recall-transcript-mode 1))

(use-package ai-code
  :ensure t
  :config
  ;; Disable side-window behavior to use regular Emacs windows/frames
  (setq ai-code-backends-infra-use-side-window nil)
  ;; Open ai-code and backend session buffers in the current window
  (add-to-list 'display-buffer-alist
               '("\\*\\(ai-code\\|antigravity\\)"
                 (display-buffer-same-window)))
  (ai-code-set-backend 'antigravity)
  (bind-key* (kbd "C-c a") #'ai-code-menu)
  (ai-code-prompt-filepath-completion-mode 1)
  (setq ai-code-auto-test-type 'ask-me)
  (setq auto-revert-interval 1)

  (with-eval-after-load 'magit
    (ai-code-magit-setup-transients)))

(provide 'chatgpt-config)
;;; chatgpt-config.el ends here
