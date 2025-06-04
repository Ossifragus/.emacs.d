(use-package chatgpt-shell
  :ensure t
  :config
  (setq chatgpt-shell-openai-key
        (auth-source-pick-first-password :host "api.openai.com"))
  (setq chatgpt-shell-google-key
        (auth-source-pick-first-password :host "aistudio.google.com"))
  (setq chatgpt-shell-openrouter-key
        (auth-source-pick-first-password :host "openrouter.ai/api/v1"))
  (setq chatgpt-shell-model-version "gpt-4.1")
  )

(use-package dall-e-shell
  :ensure t
  :config
  (setq dall-e-shell-openai-key
        (auth-source-pick-first-password :host "api.openai.com"))
  (setq dall-e-shell-image-output-directory "~/Desktop/")
  )

;; ;; Google Gemini
;; (use-package gemini
;;   :ensure t
;;   :vc (:url "https://github.com/AllTheLife/Gemini.el.git"
;;             :rev :newest)
;;   :config
;;   (require 'gemini)
;;   (setq gemini-api-token
;;         (auth-source-pick-first-password :host "aistudio.google.com"))
;;   (gemini-start-process)
;;   )

;; Github Copilot
;; https://github.com/nvm-sh/nvm
;; https://github.com/copilot-emacs/copilot.el
;; https://robert.kra.hn/posts/2023-02-22-copilot-emacs-setup/
(use-package copilot
  :ensure t
  :vc (:url "https://github.com/copilot-emacs/copilot.el.git"
            :rev :newest)
  :config
  (require 'copilot)
  (setq copilot-indent-offset-warning-disable t)
  ;; (cond
   ;; ((eq system-type 'gnu/linux)
   ;;  (progn (setq copilot-node-executable
   ;;               "~/Dropbox/App/node-v20.11.1-linux-x64/bin/node")))
   ;; ((eq system-type 'darwin)
   ;;  (progn (setq copilot-node-executable
   ;;               "~/Dropbox/App/node-v20.11.1-darwin-arm64/bin/node")))
   ;; )
  :hook ( julia-mode-hook LaTeX-mode-hook markdown-mode-hook org-mode-hook
          python-mode-hook text-mode-hook)
  :bind ( :map copilot-completion-map
          ("<tab>" . copilot-accept-completion)
          ("TAB" . copilot-accept-completion)
          :map copilot-mode-map
          ("C-<next>" . copilot-next-completion)
          ("C-<prior>" . copilot-previous-completion)
          ("C-<right>" . copilot-accept-completion-by-word)
          ("C-<down>" . copilot-accept-completion-by-line))
  )

(provide 'chatgpt-config)

