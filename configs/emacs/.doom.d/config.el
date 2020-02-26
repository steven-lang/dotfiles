;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!

;; Set frame title
(setq frame-title-format "%b - Emacs")

;; Auto unbind overridden keys
(general-auto-unbind-keys)

;; Disable dashboard banner
(defun doom-dashboard-widget-banner ())

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Steven Lang"
      user-mail-address "steven.lang.mz@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Hack" :size 18))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-one)



;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)

(setq org-directory "~/Dropbox/orgmode/")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; Set local leader to ","
(setq doom-localleader-key ",")

;; Enable reload of buffers when they change on disk
(global-auto-revert-mode t)

;; Enable highlight line
(global-hl-line-mode 1)

;; Enable word wrap mode
(+global-word-wrap-mode)

;; Company config
(setq company-minimum-prefix-length 1
      company-idle-delay 0.1)

;; Emacs config location
(setq emacs-dir (file-name-as-directory "~/.doom.d"))

;; Load custom functions
(load! "functions.el")

;; Better scrolling
(setq scroll-margin 3)


;; Set which-key delay
(setq which-key-idle-delay 0.4)
(setq which-key-idle-secondary-delay 0.4)

;; Doom modeline
(setq doom-modeline-env-python-executable "python") ; or `python-shell-interpreter'
(setq doom-modeline-env--command-args "--version")

;; Use "SPC v" to expand region
(map! :n "SPC v" #'er/expand-region)

;; Window numbers
(winum-mode)

;; When in daemon, also run edit-server
(when (daemonp)
  (use-package! edit-server
    :defer
    :config
    ;; Set server port
    (setq edit-server-port 9292)

    ;; If this is an emacs-daemon, start the edit-server
    (edit-server-start)))

(defun slang/notify-send (title message)
  (call-process "notify-send"
                nil 0 nil
                title
                message
                "--expire-time" "300000" ; 5 minutes
                "--app-name" "Emacs"
                ))


;; Keybindings
(load!  "keybindings.el")

;; Disable evil snipe
;; (after! evil-snipe (evil-snipe-mode -1))

;; Restore original yank behavior
(setq evil-want-Y-yank-to-eol nil)

;; Use offlineimap as mu4e backend
(setq +mu4e-backend 'offlineimap)
(setq +mu4e-mu4e-mail-path "~/.mail")
(set-email-account! "GMail steven.lang.mz"
                    '((mu4e-sent-folder       . "/[Gmail].Sent Mail")
                      (mu4e-drafts-folder     . "/[Gmail].Drafts")
                      (mu4e-trash-folder      . "/[Gmail].Trash")
                      (smtpmail-smtp-user     . "steven.lang.mz@gmail.com")
                      (user-mail-address      . "steven.lang.mz@gmail.com"))
                    t)

;; Get back projectile ag
(advice-remove 'helm-projectile-ag #'+helm/project-search)

;; Set latex viewer
(setq +latex-viewers '(evince))

;; Python blacken
(use-package! blacken)

;; Use helm-ag!
(use-package! helm-ag)

;; Org setup
(after! org
  (load! "org-setup.el"))

;; Disable whitespace buttler (has issues in org-mode when calling org-latex-preview)
(ws-butler-global-mode -1)

;; Helm markers
(use-package! helm-evil-markers)

;; Use aggressive indenting in emacs-lisp-mode
(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
