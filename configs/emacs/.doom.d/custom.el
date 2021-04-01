(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline success warning error])
 '(awesome-tray-mode-line-active-color "#2fafff")
 '(awesome-tray-mode-line-inactive-color "#323232")
 '(custom-safe-themes
   '("75b8719c741c6d7afa290e0bb394d809f0cc62045b93e1d66cd646907f8e6d43" "21388667ce5ee0b375e6282f0d6c6b61588da6604d343bbb19389e6a54d3d00d" "8f5a7a9a3c510ef9cbb88e600c0b4c53cdcdb502cfe3eb50040b7e13c6f4e78e" "c7f364aeea0458b6368815558cbf1f54bbdcc1dde8a14b5260eb82b76c0ffc7b" default))
 '(exwm-floating-border-color "#646464")
 '(flymake-error-bitmap '(flymake-double-exclamation-mark modus-themes-fringe-red))
 '(flymake-note-bitmap '(exclamation-mark modus-themes-fringe-cyan))
 '(flymake-warning-bitmap '(exclamation-mark modus-themes-fringe-yellow))
 '(highlight-tail-colors '(("#2f4a00" . 0) ("#00415e" . 20)))
 '(hl-todo-keyword-faces
   '(("HOLD" . "#cfdf30")
     ("TODO" . "#feacd0")
     ("NEXT" . "#b6a0ff")
     ("THEM" . "#f78fe7")
     ("PROG" . "#00d3d0")
     ("OKAY" . "#4ae8fc")
     ("DONT" . "#70c900")
     ("FAIL" . "#ff8059")
     ("BUG" . "#ff8059")
     ("DONE" . "#44bc44")
     ("NOTE" . "#f0ce43")
     ("KLUDGE" . "#eecc00")
     ("HACK" . "#eecc00")
     ("TEMP" . "#ffcccc")
     ("FIXME" . "#ff9977")
     ("XXX+" . "#f4923b")
     ("REVIEW" . "#6ae4b9")
     ("DEPRECATED" . "#bfd9ff")))
 '(ibuffer-deletion-face 'modus-themes-mark-del)
 '(ibuffer-filter-group-name-face 'modus-themes-mark-symbol)
 '(ibuffer-marked-face 'modus-themes-mark-sel)
 '(ibuffer-title-face 'modus-themes-pseudo-header)
 '(org-agenda-files
   '("~/master-thesis/thesis/results-other-papers.org" "/home/tak/org/gtd/calendar.org" "/home/tak/org/gtd/dlcv.org" "/home/tak/org/gtd/einsum-networks.org" "/home/tak/org/gtd/gtd.org" "/home/tak/org/gtd/inbox.org" "/home/tak/org/gtd/journal.org" "/home/tak/org/gtd/lily58-keyboard.org" "/home/tak/org/gtd/linux.org" "/home/tak/org/gtd/notes.org" "/home/tak/org/gtd/reference-material.org" "/home/tak/org/gtd/split-keyboard-workshop.org" "/home/tak/org/gtd/stat-ml-exam-prep.org" "/home/tak/org/gtd/tracking.org" "/home/tak/org/gtd/weekly-review.org"))
 '(org-src-block-faces 'nil)
 '(safe-local-variable-values
   '((org-ref-default-bibliography "/home/tak/master-thesis/thesis/bibliography.bib")
     (org-ref-default-bibliography "~/master-thesis/thesis/bibliography.bib")
     (org-ref-default-bibliography quote
                                   ("~/master-thesis/thesis/bibliography.bib"))
     (org-ref-default-bibliography quote
                                   ("./bibliography.bib"))
     (org-ref-default-bibliography
      '("./bibliography.bib"))
     (projectile-project-root . "~/master-thesis/thesis")
     (git-commit-major-mode . git-commit-elisp-text-mode)))
 '(vc-annotate-background-mode nil)
 '(xterm-color-names
   ["black" "#ff8059" "#44bc44" "#eecc00" "#2fafff" "#feacd0" "#00d3d0" "gray65"])
 '(xterm-color-names-bright
   ["gray35" "#f4923b" "#70c900" "#cfdf30" "#79a8ff" "#f78fe7" "#4ae8fc" "white"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-buffer-modified ((t (:inherit font-lock-comment-face :foreground "IndianRed2"))))
 '(org-agenda-structure ((t (:height 1.5 :weight ultra-bold :box (:line-width 2 :color "grey75" :style released-button)))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.3))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.25))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.15))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.1))))
 '(org-super-agenda-header ((t (:height 0.8 :box nil :inherit (org-agenda-structure))))))
