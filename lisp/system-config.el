(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))
  ;; (when (memq window-system '(mac ns x))
  ;;   (exec-path-from-shell-initialize))
  ;; (when (daemonp)
  ;;   (exec-path-from-shell-initialize)))

;; Modern replacement for openwith: dired-open
;; Automatically open these file types with external programs
;; when pressing RET in Dired or opening via find-file (C-x C-f).
(use-package dired-open
  :ensure t
  :config
  (setq dired-open-extensions
        '(("pdf"  . "papers")
          ("ps"   . "papers")
          ("djvu" . "papers")
          ("jpg"  . "loupe")
          ("jpeg" . "loupe")
          ("png"  . "loupe")
          ("webp" . "loupe")
          ("gif"  . "loupe")
          ("dot"  . "xdot")
          ("m4v"  . "smplayer")
          ("mp4"  . "smplayer")
          ("MP4"  . "smplayer")
          ("MTS"  . "smplayer")
          ("mpg"  . "smplayer")
          ("mov"  . "smplayer")
          ("avi"  . "smplayer")
          ("AVI"  . "smplayer")
          ("flv"  . "smplayer")
          ("mkv"  . "smplayer")
          ("webm" . "smplayer")
          ("xls"  . "libreoffice --calc")
          ("xlsx" . "libreoffice --calc")
          ("doc"  . "libreoffice --writer")
          ("docx" . "libreoffice --writer")
          ("odt"  . "libreoffice --writer")
          ("ppt"  . "libreoffice --impress")
          ("pptx" . "libreoffice --impress")
          ("odp"  . "libreoffice --impress")))

  ;; Intercept find-file commands (C-x C-f) before Emacs creates or parses the buffer
  (defun my/find-file-open-externally-advice (orig-fn filename &rest args)
    "Open FILENAME with external application if its extension is in `dired-open-extensions`."
    (let* ((ext (and (stringp filename)
                     (file-name-extension filename)
                     (downcase (file-name-extension filename))))
           (app (and ext (cdr (assoc ext dired-open-extensions)))))
      (if (and app (file-exists-p filename) (not (file-directory-p filename)))
          (progn
            (start-process-shell-command app nil (format "%s %s" app (shell-quote-argument (expand-file-name filename))))
            (message "Opened %s with %s" (file-name-nondirectory filename) app))
        (apply orig-fn filename args))))

  (advice-add 'find-file :around #'my/find-file-open-externally-advice)
  (advice-add 'find-file-other-window :around #'my/find-file-open-externally-advice)
  (advice-add 'find-file-other-frame :around #'my/find-file-open-externally-advice))

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
