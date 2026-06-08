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

(defun my-TeX-okular--document-spec ()
  (let ((pdf-file (expand-file-name
                   (TeX-active-master (TeX-output-extension))))
        (source-file (expand-file-name (TeX-buffer-file-name))))
    (list pdf-file
          (format "file:%s#src:%s%s"
                  pdf-file
                  (TeX-current-line)
                  source-file))))

(defun my-TeX-okular--find-instance (pdf-file)
  (when (require 'dbus nil t)
    (catch 'instance
      (dolist (service (dbus-list-names :session))
        (when (or (string= service "org.kde.okular")
                  (string-prefix-p "org.kde.okular-" service))
          (dolist (object-path (cons "/okular"
                                     (mapcar (lambda (index)
                                               (format "/okular%d" index))
                                             (number-sequence 1 16))))
            (let ((current-document
                   (ignore-errors
                     (dbus-call-method
                      :session service object-path
                      "org.kde.okular" "currentDocument"))))
              (when (and (stringp current-document)
                         (string= (expand-file-name current-document) pdf-file))
                (throw 'instance (cons service object-path))))))))))

(defun my-TeX-okular-sync-view ()
  (pcase-let* ((`(,pdf-file ,document-spec) (my-TeX-okular--document-spec))
               (instance (my-TeX-okular--find-instance pdf-file)))
    (if instance
        (condition-case nil
            (progn
              (dbus-call-method
               :session (car instance) (cdr instance)
               "org.kde.okular" "openDocument"
               document-spec)
              (ignore-errors
                (dbus-call-method
                 :session (car instance) "/okularshell"
                 "org.kde.okular" "tryRaise" "")))
          (error
           (start-process "okular" nil "okular" document-spec)))
      (start-process "okular" nil "okular" document-spec))))

(defun my-LaTeX-hook ()
	(set-face-foreground 'font-latex-math-face "burlywood")
	(set-face-foreground 'font-latex-warning-face "red")

	(local-set-key (kbd "C-c C-f") 'tex-frame)
	(local-set-key (kbd "$") 'insert-dollar-sign)
	(setq TeX-parse-self t)
	(define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)
	(tex-fold-mode t)
	(LaTeX-math-mode t)
	(visual-line-mode t)
	(flyspell-mode t)
	(auto-fill-mode t)
	;; (outline-minor-mode t)
	)

(defun insert-dollar-sign ()
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
    (unless (assoc "Okular" TeX-view-program-list)
      (add-to-list 'TeX-view-program-list
                   '("Okular" my-TeX-okular-sync-view)))
    (setq TeX-view-program-selection '((output-pdf "Okular")))))

  ;; Focus strategy for PGTK/Wayland/GNOME
  ;; install Just Perfection
  (setq TeX-raise-frame-function
        (lambda ()
          (let ((frame (selected-frame)))
            (run-at-time 0.2 nil
                         (lambda (f)
                           (when (frame-live-p f)
                             (make-frame-visible f)
                             (raise-frame f)
                             (select-frame-set-input-focus f)
                             (if (fboundp 'x-focus-frame) (x-focus-frame f))
                             (if (fboundp 'pgtk-focus-frame) (pgtk-focus-frame f))
                             ;; Fallback for GNOME/X11
                             (when (executable-find "wmctrl")
                               (let ((name (frame-parameter f 'name)))
                                 (if (and name (not (string= name "")))
                                     (call-process "wmctrl" nil nil nil "-a" name)
                                   (call-process "wmctrl" nil nil nil "-x" "-a" "Emacs"))))))
                         frame)))))

(provide 'latex-config)

;; Okular inverse search:
;; Configure Okular -> Settings -> Configure Okular -> Editor:
;;   Custom Text Editor: emacsclient --no-wait +%l %f
