(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))
  ;; (when (memq window-system '(mac ns x))
  ;;   (exec-path-from-shell-initialize))
  ;; (when (daemonp)
  ;;   (exec-path-from-shell-initialize)))

;; Modern replacement for openwith: dired-open
;; This will automatically open these file types with the specified 
;; external programs when you press RET on them in Dired.
(use-package dired-open
  :ensure t
  :config
  (setq dired-open-extensions
        '(("pdf" . "evince")
          ("jpg" . "evince")
          ("m4v" . "smplayer")
          ("mp4" . "smplayer")
          ("MP4" . "smplayer")
          ("MTS" . "smplayer")
          ("mpg" . "smplayer")
          ("mov" . "smplayer")
          ("avi" . "smplayer")
          ("AVI" . "smplayer")
          ("flv" . "smplayer")
          ("xls" . "libreoffice --calc")
          ("xlsx" . "libreoffice --calc")
          ("doc" . "libreoffice --writer")
          ("docx" . "libreoffice --writer")
          ("odt" . "libreoffice --writer"))))

;; ;; ;; Configure proxy
;; ;; (setq url-proxy-services
;; ;;       '(("http" . "127.0.0.1:7897")
;; ;;         ("https" . "127.0.0.1:7897")))

;; ;; ;; Set proxy for ChatGPT buffers only
;; ;; (add-hook 'chatgpt-shell-mode-hook
;; ;;           (lambda ()
;; ;;             (setenv "http_proxy" "http://127.0.0.1:7897")
;; ;;             (setenv "https_proxy" "http://127.0.0.1:7897")
;; ;;             (add-hook 'kill-buffer-hook
;; ;;                       (lambda ()
;; ;;                         (setenv "http_proxy" nil)
;; ;;                         (setenv "https_proxy" nil))
;; ;;                       nil t)))

;; ;; No global proxy settings at all!

;; (defun chatgpt-with-proxy (orig-func &rest args)
;;   "Run ChatGPT with proxy environment variables."
;;   (let ((process-environment (copy-sequence process-environment)))
;;     (setenv "http_proxy" "http://127.0.0.1:7897")
;;     (setenv "https_proxy" "http://127.0.0.1:7897")
;;     ;; Also set url-proxy-services for url.el
;;     (cl-letf (((symbol-value 'url-proxy-services) 
;;                '(("http" . "127.0.0.1:7897")
;;                  ("https" . "127.0.0.1:7897"))))
;;       (apply orig-func args))))

;; ;; Advise all ChatGPT functions
;; (dolist (cmd '(chatgpt-shell-send
;;                chatgpt-shell-query
;;                chatgpt-shell-query-async
;;                chatgpt-shell-send-to-shell
;;                chatgpt-shell-clear
;;                chatgpt-shell-new))
;;   (advice-add cmd :around #'chatgpt-with-proxy))

;; ;; Also handle the shell buffer
;; (defun my-chatgpt-shell-proxy-setup ()
;;   "Set proxy in chatgpt-shell buffers."
;;   (setq-local url-proxy-services '(("http" . "127.0.0.1:7897")
;;                                    ("https" . "127.0.0.1:7897")))
;;   (setenv "http_proxy" "http://127.0.0.1:7897")
;;   (setenv "https_proxy" "http://127.0.0.1:7897"))

;; (add-hook 'chatgpt-shell-mode-hook #'my-chatgpt-shell-proxy-setup)

(provide 'system-config)
