;;; latex-config.el -*- lexical-binding: t; -*-

(use-package tex
  :ensure auctex
  :init
  (setq TeX-auto-save t
        TeX-parse-self t
        TeX-PDF-mode t
        TeX-save-query nil
        TeX-source-correlate-mode t
        TeX-source-correlate-method 'synctex
        TeX-source-correlate-start-server t
        TeX-command-extra-options "--shell-escape"
        preview-scale-function 1.5
        reftex-plug-into-auctex t
        bibtex-align-at-equal-sign t)

  :config
  ;; Viewer and SyncTeX configuration
  (cond
   ((or (eq system-type 'darwin) (string= (system-name) "MBP16.local"))
    (setq TeX-view-program-list
          '(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline -g -b %n %o %b"))
          TeX-view-program-selection '((output-pdf "Skim"))))
   ((eq system-type 'gnu/linux)
    (unless (assoc "Okular" TeX-view-program-list)
      (add-to-list 'TeX-view-program-list
                   '("Okular" my-TeX-okular-sync-view)))
    (setq TeX-view-program-selection '((output-pdf "Okular")))))

  ;; Focus strategy for PGTK/Wayland/GNOME
  (setq TeX-raise-frame-function
        (lambda ()
          (let ((frame (selected-frame)))
            (run-at-time 0.2 nil
                         (lambda (f)
                           (when (frame-live-p f)
                             (make-frame-visible f)
                             (raise-frame f)
                             (select-frame-set-input-focus f)
                             (when (fboundp 'x-focus-frame) (x-focus-frame f))
                             (when (fboundp 'pgtk-focus-frame) (pgtk-focus-frame f))
                             ;; Fallback for GNOME/X11
                             (when (executable-find "wmctrl")
                               (let ((name (frame-parameter f 'name)))
                                 (if (and name (not (string= name "")))
                                     (call-process "wmctrl" nil nil nil "-a" name)
                                   (call-process "wmctrl" nil nil nil "-x" "-a" "Emacs"))))))
                         frame)))))

(use-package latex
  :ensure nil
  :after tex
  :bind (:map LaTeX-mode-map
         ("C-c C-f" . tex-frame)
         ("$"       . insert-dollar-sign)
         ("TAB"     . TeX-complete-symbol))
  :hook ((LaTeX-mode . turn-on-reftex)
         (LaTeX-mode . evil-tex-mode)
         (LaTeX-mode . my-LaTeX-hook))
  :config
  (with-eval-after-load 'evil
    (evil-define-key '(normal visual) LaTeX-mode-map
      (kbd "<leader>ca") #'TeX-command-run-all
      (kbd "<leader>cc") #'TeX-command-master)))

;;; Helper Functions

(defun insert-dollar-sign ()
  "Insert a pair of dollar signs and place point between them."
  (interactive)
  (insert "$$")
  (backward-char 1))

(defun tex-frame ()
  "Run `TeX-command-region' on the current Beamer frame environment."
  (interactive)
  (save-mark-and-excursion
    (while (not (looking-at-p "\\\\begin *{frame}"))
      (LaTeX-find-matching-begin))
    (forward-char)
    (LaTeX-mark-environment)
    (TeX-command-region)))

(defun tex-remove-comments (&optional beg end)
  "Remove all LaTeX comments in the current buffer or active region.
Full-line comments are deleted along with their trailing newline so as not
to introduce spurious paragraph breaks (\\par).  Inline comments are deleted
along with any preceding horizontal whitespace.  Escaped percent characters
(\\%) and verbatim/macro constructs are preserved."
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (list (point-min) (point-max))))
  (let ((count 0))
    (save-excursion
      (save-restriction
        (narrow-to-region (or beg (point-min)) (or end (point-max)))
        (syntax-propertize (point-max))
        (goto-char (point-min))
        (while (re-search-forward "%" nil t)
          (let ((state (syntax-ppss (point))))
            (when (and (nth 4 state)
                       (not (nth 3 state))
                       (not (and (fboundp 'LaTeX-verbatim-p)
                                 (LaTeX-verbatim-p (1- (point))))))
              (setq count (1+ count))
              (let ((comment-start (1- (point))))
                (if (string-match-p "\\`[ \t]*\\'"
                                    (buffer-substring-no-properties
                                     (line-beginning-position)
                                     comment-start))
                    ;; Full-line comment (only whitespace before `%').
                    ;; Delete the line including the newline (if any).
                    (delete-region (line-beginning-position)
                                   (if (= (line-end-position) (point-max))
                                       (point-max)
                                     (1+ (line-end-position))))
                  ;; Inline comment: delete from comment-start to end-of-line.
                  (goto-char comment-start)
                  (skip-chars-backward " \t")
                  (delete-region (point) (line-end-position)))))))))
    (when (called-interactively-p 'interactive)
      (message "Removed %d comment%s." count (if (= count 1) "" "s")))
    count))

(defalias 'latex-remove-comments #'tex-remove-comments)

(defun my-LaTeX-hook ()
  "Custom setup for `LaTeX-mode'."
  (set-face-foreground 'font-latex-math-face "burlywood")
  (set-face-foreground 'font-latex-warning-face "red")
  (tex-fold-mode 1)
  (LaTeX-math-mode 1)
  (visual-line-mode 1)
  (flyspell-mode 1)
  (auto-fill-mode 1)
  (display-line-numbers-mode 1))

;;; Okular DBus SyncTeX Integration (Linux)

(defun my-TeX-okular--document-spec ()
  (let ((pdf-file (expand-file-name
                   (TeX-active-master (TeX-output-extension))))
        (source-file (expand-file-name (TeX-buffer-file-name))))
    (list pdf-file
          (format "file:%s#src:%s %s"
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

(provide 'latex-config)
;;; latex-config.el ends here
