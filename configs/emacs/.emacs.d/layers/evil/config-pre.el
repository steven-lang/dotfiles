;; Evilify emacs!
(use-package evil
  :diminish undo-tree-mode
  :init
  (setq evil-want-C-u-scroll t
        evil-want-keybinding nil
        evil-shift-width ian/indent-width)
  :hook (after-init . evil-mode)
  :config
  (with-eval-after-load 'evil-maps ; avoid conflict with company tooltip selection
    )
  )

;; Evil collection
(use-package evil-collection
  :after evil
  :config
  ;; (setq evil-collection-company-use-tng nil)
  (evil-collection-init))

;; Enable evil commentary (gcc etc)
(use-package evil-commentary
  :after evil
  :diminish
  :config (evil-commentary-mode +1))

;; Enable evil magit bindings
(use-package evil-magit)

;; Enable evil surround
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))
