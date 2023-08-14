;; poly-julia.el --- Polymode for Julia language -*- lexical-binding: t -*-
;;
;; Copyright (C) 2020 Shigeaki Nishina
;; Author: Shigeaki Nishina
;; Maintainer: Shigeaki Nishina
;; URL: https://github.com/shg/poly-julia
;; Version: 0.1
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;; License:
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see https://www.gnu.org/licenses/.
;;
;;; Code:

;; (require 'julia-mode)
;; (require 'poly-markdown)
(use-package poly-markdown
  :ensure t)

;; (require 'julia-repl-vterm)
;; (require 'julia-vterm)
(use-package julia-vterm
  :ensure t)

(define-innermode poly-julia-markdown-inline-code-innermode poly-markdown-inline-code-innermode
  :mode 'julia-mode
  :head-matcher (cons "^[ \t]*\\(```{?[Jj]ulia.*\n\\)" 1)
  :tail-matcher (cons "^[ \t]*\\(```\\)[ \t]*$" 1)
  :head-mode 'host
  :tail-mode 'host)

(define-polymode poly-markdown+julia-mode poly-markdown-mode :lighter " PM-jmd"
  :innermodes '(poly-julia-markdown-inline-code-innermode))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.[jJ]md" . poly-markdown+julia-mode))

;;; Weave.jl settings
(defun poly-julia-run-command (command callback &rest _ignore)
  (let ((inferior-buffer (inferior-julia-repl-vterm-buffer)))
    (display-buffer inferior-buffer)
    (with-current-buffer inferior-buffer
      (julia-with-repl-vterm-send-string command)
      (julia-with-repl-vterm-send-string "\n")
      (goto-char (point-max)))))

(defun poly-julia-callback (proc string))

(defvar poly-julia-weavejl-weavers
  (pm-callback-weaver :name "JMarkdown"
		      :from-to
		      '(("markdown" "\\.j?md]\\'" "md" "Markdown" "using Weave; weave(\"%I\", mod=Main, doctype=\"multimarkdown\", fig_path=\"pdf\/%i\/\", fig_ext=\".pdf\", cache=:on)"))
		      :function 'poly-julia-run-command
		      :callback 'poly-julia-callback))

(polymode-register-weaver poly-julia-weavejl-weavers nil
                          poly-markdown-polymode)

(defun jmarkdown-weave-to-markdown ()
  (interactive)
  (oset pm/polymode :weaver 'poly-julia-weavejl-weavers)
  (save-excursion
    (polymode-weave "markdown")))

;; Hooks
(add-hook 'markdown-mode-hook
	  (lambda ()
	    (when (boundp 'poly-markdown+julia-mode)
	      (define-key poly-markdown+julia-mode-map (kbd "C-c o") #'julia-with-repl-vterm-switch-to-repl-buffer)
	      (define-key poly-markdown+julia-mode-map (kbd "C-c C-z") #'julia-with-repl-vterm-switch-to-repl-buffer)
	      (define-key poly-markdown+julia-mode-map (kbd "C-c w") 'jmarkdown-weave-to-markdown)
	      (define-key poly-markdown+julia-mode-map (kbd "C-l") 'recenter-top-bottom)))
	  'append)

(provide 'poly-julia)
