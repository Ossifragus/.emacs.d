;;; early-init.el --- Early Initialization Settings -*- lexical-binding: t; -*-

;; 1. Prevent Garbage Collection during startup for faster boot times
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Reset GC after startup completes
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024)   ; 16 MB
                  gc-cons-percentage 0.1)))

;; 2. Prevent UI flickering by disabling bars before the frame renders
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)

;; 3. Machine-specific frame geometry & fonts
(cond
 ((member (system-name) '("aust319" "t1700" "OSHome"))
  (setq default-frame-alist
        '((top . 0)
          (left . 0)
          (height . 54)
          (width . 88)
          (font . "JuliaMono-16"))))

 ((string= (system-name) "yoga")
  (setq default-frame-alist
        '((height . 39)
          (width . 81)
          (font . "JuliaMono-12"))))

 ((or (eq system-type 'darwin) (string= (system-name) "MBP16.local"))
  (setq default-frame-alist
        '((height . 99)
          (width . 81)
          (font . "JuliaMono-16"))))

 (t
  (push '(font . "JuliaMono-16") default-frame-alist)))

;; Ensure initial frame inherits these settings
(setq initial-frame-alist default-frame-alist)

;;; early-init.el ends here
