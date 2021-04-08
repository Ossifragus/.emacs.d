;; (add-to-list 'load-path
;;               "~/.emacs.d/elpa/yasnippet-20200604.246")
;;               ;; "~/.emacs.d/elpa/yasnippet-0.14.0")
;; (require 'yasnippet)
(yas-global-mode 1)

(require 'ediff)

;; Python 
;; '(package-selected-packages
;;    '(anaconda-mode elpy))
(elpy-enable)
(setq python-shell-virtualenv-path "/home/ossifragus/anaconda3/")
(setq elpy-rpc-python-command "/home/ossifragus/anaconda3/bin/python")
(setq python-shell-interpreter "/home/ossifragus/anaconda3/bin/python")
(add-hook 'python-mode-hook 'anaconda-mode)
(define-key elpy-mode-map (kbd "C-c C-r") 'elpy-shell-send-region-or-buffer)
(defun my-elpy-mode-hook-fun ()
 "Function to be installed in `elpy-mode-hook'."
 ;; (local-set-key (kbd "C-c C-r") 'elpy-shell-send-region-or-buffer-and-go)
 ;; (cua-selection-mode -1)
 (company-mode t)
)
(add-hook 'elpy-mode-hook 'my-elpy-mode-hook-fun)
;; (add-hook 'after-init-hook 'global-company-mode)

;; Gmail
(setq gnus-select-method '(nnimap "gmail"
				  (nnimap-address "imap.gmail.com")
				  (nnimap-server-port 993)
				  (nnimap-stream ssl)))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "whygps@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-local-domain "yourcompany.com")

(setq gnus-thread-sort-functions
      '(
        (not gnus-thread-sort-by-date)
        (not gnus-thread-sort-by-number)
        ))

CUA mode
(cua-mode nil)
(cua-selection-mode nil)
;; (setq cua-auto-tabify-rectangles nil)
;; (setq cua-enable-cua-keys nil)


;; start the server
(server-start)

(require 'openwith)
(openwith-mode t)
(setq openwith-associations '(("\\.pdf\\'" "evince" (file))))

;; CUA mode
(cua-selection-mode t)
(setq cua-auto-tabify-rectangles nil) 

;; (load "~/Emacs/htmlize.el")
(require 'htmlize)
;;(setq htmlize-output-type "css")
;;(setq htmlize-output-type "inline-css")
(setq htmlize-output-type "font")

;;;;;;;; MatLab
(setq load-path (cons "~/Dropbox/.Emacs/matlab/" load-path))
(load-library "matlab-load")
    ;; (matlab-cedet-setup)

;; (require 'dictem)
(setq ispell-program-name "aspell")

