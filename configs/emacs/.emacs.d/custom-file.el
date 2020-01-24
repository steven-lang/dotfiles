(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-prefix-format
   '((agenda . "  %t ")
     (todo . "  • ")
     (tags . "  • ")
     (search . "  • ")))
 '(org-modules
   '(ol-bbdb ol-bibtex ol-docview ol-eww ol-gnus ol-info ol-irc ol-mhe org-protocol ol-rmail ol-w3m org-habit org-ql))
 '(org-priority-faces '((66 . "#f99157") (67 . "#65737e")))
 '(org-super-agenda-mode t)
 '(package-selected-packages
   '(python-black zetteldeft yasnippet-snippets xclip winum which-key use-package srefactor rainbow-mode rainbow-delimiters pyvenv posframe origami org-ref org-ql org-gcal org-bullets lsp-ui lsp-python-ms json-mode ido-vertical-mode ido-completing-read+ hl-todo highlight-operators highlight-numbers highlight-escape-sequences helm-projectile helm-lsp helm-ag graphviz-dot-mode general flycheck flx-ido expand-region exec-path-from-shell evil-surround evil-magit evil-leader evil-commentary evil-collection elisp-slime-nav edit-server doom-themes doom-modeline direnv diminish dashboard dap-mode csv-mode company-lsp atomic-chrome)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil))))
 '(helm-buffer-modified ((t (:inherit font-lock-comment-face :foreground "IndianRed2"))))
 '(org-agenda-structure ((t (:foreground "#ECEFF4" :box (:line-width 1 :style released-button) :weight ultra-bold :height 1.5))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.3))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.25))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.15))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.1))))
 '(org-super-agenda-header ((t (:inherit org-agenda-structure :box nil :height 0.8)))))
