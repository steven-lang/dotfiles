(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(conda-anaconda-home "~/.conda")
 '(conda-env-home-directory (expand-file-name "~/.conda/") t)
 '(custom-safe-themes
   '("f7216d3573e1bd2a2b47a2331f368b45e7b5182ddbe396d02b964b1ea5c5dc27" default))
 '(org-agenda-prefix-format
   '((agenda . "  %t ")
     (todo . "  • ")
     (tags . "  • ")
     (search . "  • ")))
 '(org-modules
   '(ol-bbdb ol-bibtex ol-docview ol-eww ol-gnus ol-info ol-irc ol-mhe org-protocol ol-rmail ol-w3m org-habit org-ql) t)
 '(org-priority-faces '((66 . "#f99157") (67 . "#65737e")))
 '(safe-local-variable-values
   '((TeX-master . "~/master-thesis/thesis/main.tex")
     (projectile-project-root . "~/master-thesis/thesis"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-buffer-modified ((t (:inherit font-lock-comment-face :foreground "IndianRed2"))))
 '(org-agenda-structure ((t (:height 1.5 :weight ultra-bold :foreground "#bbc2cf" :box (:line-width 2 :color "grey75" :style released-button)))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.3))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.25))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.15))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.1))))
 '(org-super-agenda-header ((t (:height 0.8 :box nil :inherit (org-agenda-structure))))))
