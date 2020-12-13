;;; ../dotfiles/configs/emacs/.doom.d/ui/+theme.el -*- lexical-binding: t; -*-

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
;; (let ((h (string-to-number (format-time-string "%H"))))
;;   (if (or (< h 8)
;;           (> h 21))
;;       (setq doom-theme 'doom-nord)
;;     (setq doom-theme 'doom-nord-light)))
;; (setq doom-theme 'doom-nord)
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-nord)
;; (setq slang/theme-light 'modus-operandi)
;; (setq slang/theme-dark 'modus-vivendi)
;; TODO: use doom-modus-operandi but also load modus-operandi first
(setq slang/theme-light 'doom-gruvbox-light)
(setq slang/theme-dark 'doom-one)
(setq doom-theme slang/theme-dark)

;; Theme based on daytime/long/lat
;; (use-package! circadian
;;   :config
;;   (setq calendar-latitude 49.9)
;;   (setq calendar-longitude 8.2)
;;   (setq circadian-themes `((:sunrise . ,slang/theme-light)
;;                            (:sunset  . ,slang/theme-dark)))
;;   ;; Add pdf view mode hook to enable pdf midnight mode on theme change
;;   (add-hook 'circadian-after-load-theme-hook
;;             #'(lambda (theme)
;;                 (if (eq theme slang/theme-dark )
;;                     (add-hook 'pdf-view-mode-hook 'slang/enable-pdf-view-midnight-minor-mode)
;;                   (remove-hook 'pdf-view-mode-hook 'slang/enable-pdf-view-midnight-minor-mode))
;;                 ))

;;   ;; Set a global variable to the active theme set by circadian el
;;   (add-hook 'circadian-after-load-theme-hook
;;             #'(lambda (theme)
;;                 (setq slang/global-active-theme theme)))

;;   (circadian-setup))
