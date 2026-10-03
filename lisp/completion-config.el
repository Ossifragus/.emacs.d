;;; completion-config.el -*- lexical-binding: t; -*-

;; Enable Vertico
(use-package vertico
  :ensure t
  :custom
  (vertico-preselect 'first)
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy)
  :init
  (vertico-mode 1))

;; Persist history over Emacs restarts (built-in)
(use-package savehist
  :init
  (savehist-mode 1))

;; Rich annotations in the minibuffer
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode 1))

;; Advanced search and navigation
(use-package consult
  :ensure t
  :bind (("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)
         ("C-x r b" . consult-bookmark)
         ("M-y" . consult-yank-pop)
         ("<help> a" . consult-apropos)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("M-s d" . consult-find)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s m" . consult-multi-occur)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ("M-s e" . consult-isearch-history))
  :config
  (setq consult-narrow-key "<"))

;; Emacs minibuffer configurations
(use-package emacs
  :init
  (context-menu-mode 1)
  :custom
  (enable-recursive-minibuffers t)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

;; Orderless completion style
(use-package orderless
  :ensure t
  :custom
  (orderless-matching-styles '(orderless-literal orderless-regexp orderless-flex))
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion orderless))))
  (completion-category-defaults nil))

;; Top-level definition to avoid compilation warnings in Emacs 31
(defvar-local corfu-mode--set-explicitly nil)

;; Corfu for in-buffer completion
(use-package corfu
  :ensure t
  :custom
  (corfu-auto t)
  (corfu-quit-no-match 'separator)
  (global-corfu-minibuffer nil)
  :init
  (global-corfu-mode 1))

;; Cape completion extensions
(use-package cape
  :ensure t
  :init
  ;; Add file completion and append fallback dabbrev globally
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev t))

(provide 'completion-config)
;;; completion-config.el ends here
