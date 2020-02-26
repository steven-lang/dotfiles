;; Helm for everything search related
(use-package helm
    :init
    (setq helm-M-x-fuzzy-match t
    helm-mode-fuzzy-match t
    helm-buffers-fuzzy-matching t
    helm-recentf-fuzzy-match t
    helm-locate-fuzzy-match t
    helm-semantic-fuzzy-match t
    helm-imenu-fuzzy-match t
    helm-completion-in-region-fuzzy-match t
    helm-candidate-number-list 150
    helm-split-window-in-side-p t
    helm-move-to-line-cycle-in-source t
    helm-echo-input-in-header-line t
    helm-autoresize-max-height 0
    helm-autoresize-min-height 20)
    :bind (:map helm-map
            ("C-k" . helm-previous-line)
            ("C-h" . helm-find-files-up-one-level)
            ("C-j" . helm-next-line))
    :config
    
    ;; (define-key helm-find-files-map "\t" 'helm-execute-persistent-action)
    (helm-mode 1))

;; Helm-ag
(use-package helm-ag)
(use-package helm-projectile)
