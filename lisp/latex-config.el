;; (setenv "PATH"
;; 				(concat
;; 				 "/usr/local/texlive/2019/bin/x86_64-linux" ":"
;; 				 (getenv "PATH")))
(setq reftex-plug-into-auctex t)
(setq preview-scale-function 1.5)
;; (setq TeX-auto-save nil)
(setq TeX-auto-save t)
(setq TeX-PDF-mode t)
(setq TeX-save-query  nil)
(setq bibtex-align-at-equal-sign t)
;; (server-start)
(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-start-server t)
(setq TeX-command-extra-options "--shell-escape")

(defun my-TeX-evince-sync-view ()
  (require 'url-util)
  (let* ((uri (concat "file://"
                      (replace-regexp-in-string
                       "[?]" "%3F"
                       (url-encode-url
                        (expand-file-name
                         (TeX-active-master (TeX-output-extension)))))))
         (owner (dbus-call-method
                 :session "org.gnome.Evince.Daemon"
                 "/org/gnome/Evince/Daemon"
                 "org.gnome.Evince.Daemon"
                 "FindDocument"
                 uri
                 t)))
    (if owner
        (with-current-buffer (or (when TeX-current-process-region-p
                                   (get-file-buffer (TeX-region-file t)))
                                 (current-buffer))
          (dbus-call-method
           :session owner
           "/org/gnome/Evince/Window/0"
           "org.gnome.Evince.Window"
           "SyncView"
           (TeX-buffer-file-name)
           (list :struct :int32 (1+ (TeX-current-offset))
                 :int32 (1+ (current-column)))
           :uint32 0)
          (when (and (boundp 'TeX-view-evince-keep-focus)
                     TeX-view-evince-keep-focus)
            (select-frame-set-input-focus (selected-frame))))
      (error "Couldn't find the Evince instance for %s" uri))))

(defun my-TeX-evince-register-inverse-search ()
  (interactive)
  (require 'dbus)
  (dbus-register-signal
   :session nil "/org/gnome/Evince/Window/0"
   "org.gnome.Evince.Window"
   "SyncSource"
   #'TeX-source-correlate-sync-source))

(add-hook 'LaTeX-mode-hook 'my-TeX-evince-register-inverse-search)

(defun my-LaTeX-hook ()
	(set-face-foreground 'font-latex-math-face "burlywood")
	(set-face-foreground 'font-latex-warning-face "red")

	(local-set-key (kbd "C-c C-f") 'tex-frame)
	(local-set-key (kbd "$") 'insert-dollor-sign)
	(setq TeX-parse-self t)
	(define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)
	(tex-fold-mode t)
	(LaTeX-math-mode t)
	(visual-line-mode t)
	(flyspell-mode t)
	(auto-fill-mode t)
	;; (outline-minor-mode t)
	)

(defun insert-dollor-sign ()
  (interactive)
  (insert "$$")
  (backward-char 1))

;; http://mbork.pl/2016-07-04_Compiling_a_single_Beamer_frame_in_AUCTeX
(defun tex-frame ()
  "Run `TeX-command-region' on the current frame environment."
  (interactive)
  (save-mark-and-excursion
    (while (not (looking-at-p "\\\\begin *{frame}"))
      (LaTeX-find-matching-begin))
    (forward-char)
    (LaTeX-mark-environment)
    (TeX-command-region)))

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'my-LaTeX-hook)
(add-hook 'LaTeX-mode-hook #'evil-tex-mode)
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map
                        (kbd "<leader>ca") 'TeX-command-run-all)
            (define-key evil-visual-state-local-map
                        (kbd "<leader>ca") 'TeX-command-run-all)
            (define-key evil-normal-state-local-map
                        (kbd "<leader>cc") 'TeX-command-master)
            (define-key evil-visual-state-local-map
                        (kbd "<leader>cc") 'TeX-command-master)
            ))

(with-eval-after-load 'tex
  (cond
   ((or (eq system-type 'darwin) (string= (system-name) "MBP16.local"))
    (setq TeX-source-correlate-method 'synctex
          TeX-view-program-list
          '(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline -g -b %n %o %b"))
          TeX-view-program-selection '((output-pdf "Skim"))))
   ((eq system-type 'gnu/linux)
    (add-to-list 'TeX-view-program-list
                 '("Evince-Pascal" my-TeX-evince-sync-view))
    (setq TeX-view-program-selection '((output-pdf "Evince-Pascal")))))

  ;; Focus strategy for PGTK/Wayland/GNOME
  (setq TeX-raise-frame-function
        (lambda ()
          (let ((frame (selected-frame)))
            (run-at-time 0.1 nil
                         (lambda (f)
                           (when (frame-live-p f)
                             (make-frame-visible f)
                             (select-frame-set-input-focus f)
                             (raise-frame f)
                             (if (fboundp 'x-focus-frame) (x-focus-frame f))
                             (if (fboundp 'pgtk-focus-frame) (pgtk-focus-frame f))
                             ;; Fallback for GNOME
                             (when (executable-find "wmctrl")
                               (call-process "wmctrl" nil nil nil "-a" "Emacs"))))
                         frame)))))

(provide 'latex-config)

;; for inverse search to bring emacs to front
;; This is the most comprehensive customization tool for GNOME and is usually the first to be updated for new GNOME versions.
;; 1.  Search for Just Perfection in your Extension Manager or on the GNOME Extensions website.
;; 2.  Install and open its Settings.
;; 3.  Go to the Behavior tab.
;; 4.  Look for Window Demands Attention Focus and turn it ON.
;; 5.  This will bypass the "Window is ready" notification and focus Emacs immediately.
