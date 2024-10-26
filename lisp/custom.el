(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(connection-local-criteria-alist
   '(((:application tramp :protocol "kubernetes")
      tramp-kubernetes-connection-local-default-profile)
     ((:application eshell) eshell-connection-default-profile)
     ((:application tramp) tramp-connection-local-default-system-profile
      tramp-connection-local-default-shell-profile)))
 '(connection-local-profile-alist
   '((tramp-kubernetes-connection-local-default-profile
      (tramp-config-check . tramp-kubernetes--current-context-data)
      (tramp-extra-expand-args 97
                               (tramp-kubernetes--container
                                (car tramp-current-connection))
                               104
                               (tramp-kubernetes--pod
                                (car tramp-current-connection))
                               120
                               (tramp-kubernetes--context-namespace
                                (car tramp-current-connection))))
     (eshell-connection-default-profile (eshell-path-env-list))
     (tramp-connection-local-darwin-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o"
                                        "pid,uid,user,gid,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                        "-o" "state=abcde" "-o"
                                        "ppid,pgid,sess,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etime,pcpu,pmem,args")
      (tramp-process-attributes-ps-format (pid . number) (euid . number)
                                          (user . string) (egid . number)
                                          (comm . 52) (state . 5)
                                          (ppid . number) (pgrp . number)
                                          (sess . number) (ttname . string)
                                          (tpgid . number) (minflt . number)
                                          (majflt . number)
                                          (time . tramp-ps-time) (pri . number)
                                          (nice . number) (vsize . number)
                                          (rss . number) (etime . tramp-ps-time)
                                          (pcpu . number) (pmem . number) (args)))
     (tramp-connection-local-busybox-ps-profile
      (tramp-process-attributes-ps-args "-o"
                                        "pid,user,group,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                        "-o" "stat=abcde" "-o"
                                        "ppid,pgid,tty,time,nice,etime,args")
      (tramp-process-attributes-ps-format (pid . number) (user . string)
                                          (group . string) (comm . 52)
                                          (state . 5) (ppid . number)
                                          (pgrp . number) (ttname . string)
                                          (time . tramp-ps-time) (nice . number)
                                          (etime . tramp-ps-time) (args)))
     (tramp-connection-local-bsd-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o"
                                        "pid,euid,user,egid,egroup,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                        "-o"
                                        "state,ppid,pgid,sid,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etimes,pcpu,pmem,args")
      (tramp-process-attributes-ps-format (pid . number) (euid . number)
                                          (user . string) (egid . number)
                                          (group . string) (comm . 52)
                                          (state . string) (ppid . number)
                                          (pgrp . number) (sess . number)
                                          (ttname . string) (tpgid . number)
                                          (minflt . number) (majflt . number)
                                          (time . tramp-ps-time) (pri . number)
                                          (nice . number) (vsize . number)
                                          (rss . number) (etime . number)
                                          (pcpu . number) (pmem . number) (args)))
     (tramp-connection-local-default-shell-profile (shell-file-name . "/bin/sh")
                                                   (shell-command-switch . "-c"))
     (tramp-connection-local-default-system-profile (path-separator . ":")
                                                    (null-device . "/dev/null"))))
 '(default-input-method "TeX")
 '(eglot-connect-timeout 300)
 '(elpy-shell-starting-directory 'current-directory)
 '(inhibit-startup-screen t)
 '(markdown-command
   "pandoc -c /home/ossifragus/Dropbox/App/reinstallOS/style/github-pandoc.css --from=markdown -t html5 --highlight-style pygments --standalone --mathjax --quiet --citeproc --template /home/ossifragus/Dropbox/App/reinstallOS/style/GitHub.html")
 '(org-agenda-files nil)
 '(org-safe-remote-resources '("\\`https://fniessen\\.github\\.io\\(?:/\\|\\'\\)"))
 '(package-selected-packages
   '(atomic-chrome auto-highlight-symbol beacon browse-kill-ring cdlatex
                   chatgpt-shell citeproc color-theme-sanityinc-tomorrow
                   company-math conda copilot counsel dall-e-shell diff-hl
                   edit-server-htmlize eglot-jl elpy emacs-everywhere ess
                   evil-better-visual-line evil-collection evil-extra-operator
                   evil-matchit evil-org evil-surround
                   evil-terminal-cursor-changer evil-tex evil-textobj-line
                   evil-tutor evil-visual-mark-mode exec-path-from-shell forge
                   gemini gnu-elpa-keyring-update highlight-numbers
                   highlight-parentheses julia-mode julia-repl kill-ring-search
                   ob-julia-vterm openwith org-evil org-re-reveal org-unique-id
                   ox-gfm ox-reveal pdf-view-restore poly-R poly-org projectile
                   smex sqlite3 undo-tree yaml-mode))
 '(package-vc-selected-packages
   '((copilot :url "https://github.com/copilot-emacs/copilot.el.git")
     (gemini :url "https://github.com/AllTheLife/Gemini.el.git"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(vterm-color-black ((t (:foreground "#3F3F3F" :background "#992323"))))
 '(vterm-color-blue ((t (:foreground "#7CB8BB" :background "#4C7073"))))
 '(vterm-color-cyan ((t (:foreground "#93E0E3" :background "#8CD0D3"))))
 '(vterm-color-green ((t (:foreground "#7F9F7F" :background "#9FC59F"))))
 '(vterm-color-magenta ((t (:foreground "#DC8CC3" :background "#CC9393"))))
 '(vterm-color-red ((t (:foreground "#AC7373" :background "#8C5353"))))
 '(vterm-color-white ((t (:foreground "#DCDCCC" :background "#656555"))))
 '(vterm-color-yellow ((t (:foreground "#DFAF8F" :background "#9FC59F"))))
 '(vterm-default-bg-color ((t (:inherit vterm-color-black))))
 '(vterm-default-fg-color ((t (:inherit vterm-color-white)))))
