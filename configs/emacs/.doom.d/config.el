;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!

;; Set frame title
(setq frame-title-format "%b - Emacs")

;; Don't confirm killing emacs
(setq confirm-kill-emacs nil)

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
;; (setq doom-font (font-spec :family "Hack" :size 19))
(setq doom-font (font-spec :family "DejaVu Sans Mono" :size 19))
;; (setq doom-font (font-spec :family "IBM Plex Mono" :size 20 :weight 'semi-light))
;; (setq doom-font (font-spec :family "DroidSansMono Nerd Font" :size 20))
;; (setq doom-variable-pitch-font (font-spec :family "DejaVu Serif" :size 25 :weight 'semi-light))
;; (setq doom-variable-pitch-font (font-spec :family "Source Sans Pro" :size 28 :weight 'semi-light))

;; Add some more space between the lines
(setq line-spacing 0.17)


;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)


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
(add-hook! 'rainbow-mode-hook
  (hl-line-mode (if rainbow-mode -1 +1)))

;; Enable word wrap mode
(+global-word-wrap-mode)

;; Company config
(setq
 ;; company-minimum-prefix-length 1
 company-idle-delay 0.1
 company-tooltip-idle-delay 0.1)

;; Emacs config location
(setq emacs-dir (file-name-as-directory "~/.doom.d"))


;; Better scrolling
(setq scroll-margin 3)

;; Set which-key delay
(setq which-key-idle-delay 0.4)
(setq which-key-idle-secondary-delay 0.4)

;; Doom modeline
(setq doom-modeline-major-mode-icon t)

;; Keybindings
(load!  "+keybindings")

;; Load custom functions
(load! "+functions")

;; Langtool
(setq langtool-java-classpath
      "/usr/share/languagetool:/usr/share/java/languagetool/*")

;; Enable rainbow delimiters in prog mode
(use-package! rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))


;; Bury compilation buffers if successful
;; (add-hook 'compilation-finish-functions 'slang/bury-compile-buffer-if-successful)

;; EMACS ANYWHERE
;; Define a function or use a lambda of the same signature
(defun popup-handler (app-name window-title x y w h)
  (markdown-mode))

;; Hook your function
(add-hook 'ea-popup-hook 'popup-handler)

;; Fix doom modeline icons (only issue on arch emacs binary)
(custom-set-faces!
  ;; Flycheck check symbol and sim-card symbol (right-hand side)
  '(doom-modeline-warning :inherit warning)
  '(doom-modeline-debug :inherit font-lock-doc-face :slant normal)

  ;; Insert/normal state (left-hand side)
  '(doom-modeline-evil-emacs-state :inherit font-lock-builtin-face)
  '(doom-modeline-evil-insert-state :inherit font-lock-keyword-face)
  '(doom-modeline-info :inherit success))


;; (use-package! s)
;; ;; Load all private modules
;; (defun slang/load-private-module (module)
;;   "Load a specific private module in the config directory."
;;   (load! (s-join "/" `(,emacs-dir "+modules" ,module "config"))))

;; ;; Set directioreis of org, org-roam and deft
;; (setq deft-directory "~/org/notes/")
;; (setq org-directory "~/org/")
;; (setq org-roam-directory "~/org/notes")
;; (setq slang/private-modules '("emacs-lisp"
;;                              "evil"
;;                              "julia"
;;                              "latex"
;;                              "lsp"
;;                              "mu4e"
;;                              "org"
;;                              "pdf"
;;                              "python"
;;                              "ui"))

;; (dolist (module slang/private-modules)
;;   (slang/load-private-module module))

(use-package! ssh-agency)
