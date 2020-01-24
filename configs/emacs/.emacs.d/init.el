;; Emacs config location
(setq emacs-dir (file-name-as-directory "~/.emacs.d"))

;; Remove scratch buffer text
(setq initial-scratch-message nil)

;; Load custom functions
(load-file (concat emacs-dir "functions.el"))

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      file-name-handler-alist nil
      site-run-file nil)

(defvar ian/gc-cons-threshold 20000000)

(add-hook 'emacs-startup-hook ; hook run after loading init files
          (lambda ()
            (setq gc-cons-threshold ian/gc-cons-threshold
                  gc-cons-percentage 0.1)))

(add-hook 'minibuffer-setup-hook (lambda ()
                                   (setq gc-cons-threshold (* ian/gc-cons-threshold 2))))
(add-hook 'minibuffer-exit-hook (lambda ()
                                  (garbage-collect)
                                  (setq gc-cons-threshold ian/gc-cons-threshold)))

(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(setq package-enable-at-startup nil)
(package-initialize)

;; Setting up the package manager. Install if missing.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t))

(defvar ian/indent-width 4) ; change this value to your preferred width

;; Startup settings
(setq frame-title-format '("Emacs")
    ring-bell-function 'ignore       ; minimise distraction
    frame-resize-pixelwise t
    inhibit-startup-screen t
    default-directory "~/")

;; Disable tool/menu/scroll bars
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; better scrolling experience
(setq scroll-margin 3
    scroll-conservatively 10000
    scroll-preserve-screen-position t
    auto-window-vscroll nil)

;; increase line space for better readability
(setq-default line-spacing nil)

;; Always use spaces for indentation
(setq-default indent-tabs-mode nil
            tab-width ian/indent-width)

;; (use-package autorevert
;;   :ensure nil
;;   :config
;;   (global-auto-revert-mode +1)
;;   (setq auto-revert-interval 2
;;         auto-revert-check-vc-info t
;;         global-auto-revert-non-file-buffers t
;;         auto-revert-verbose nil))

(use-package eldoc
  :ensure nil
  :diminish eldoc-mode
  :config
  (global-eldoc-mode +1)
  (setq eldoc-idle-delay 0.4))

;; enable paren mode
(setq show-paren-delay 0)
(show-paren-mode +1)

;; Set font
(when (member "Hack" (font-family-list))
  (set-frame-font "Hack-15" t t))

;; Scale frame
(set-face-attribute 'default (selected-frame) :height 130)

;; Split ediff window horizontally
(setq ediff-split-window-function 'split-window-horizontally)

;; Enable global line highlighting
(global-hl-line-mode t)

;; Enable global visual line (word wrap etc)
(global-visual-line-mode 1)

;; Enable electric pair mode in programming modes
(add-hook 'prog-mode-hook 'electric-pair-mode)

;; Set custom file path
(setq custom-file (concat emacs-dir "custom-file.el"))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo
        dashboard-banner-logo-title "Custom Emacs Config"
        dashboard-items nil
        dashboard-set-footer nil))

;; Highlight numbers in programming modes
(use-package highlight-numbers
  :hook (prog-mode . highlight-numbers-mode))

;; Highlight operators in programming modes
(use-package highlight-operators
  :hook (prog-mode . highlight-operators-mode))

;; Highlight escape sequences in programming modes
(use-package highlight-escape-sequences
  :hook (prog-mode . hes-mode))

;; String utilitites (e.g. s-join)
(use-package s
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Main emacs config finished here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Now load big packages in layers

(slang/load-layers '("org"
                     "lsp"
                     "lisp"
                     "zetteldeft"
                     "python"
                     "evil"
                     "company"
                     "helm"))

;; Magit!
(use-package magit
  :config (add-hook 'with-editor-mode-hook #'evil-insert-state))

;; Flycheck linter
(use-package flycheck)

;; Markdown-mode
(use-package markdown-mode :hook (markdown-mode . visual-line-mode))

;; Json mode
(use-package json-mode)

;; Deminish mode ??
(use-package diminish)

;; Which-key: Helps with keybindings
(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode +1)
  (setq which-key-idle-delay 0.4
        which-key-idle-secondary-delay 0.4))

;; Use shell PATH
(use-package exec-path-from-shell
  :config (when (memq window-system '(mac ns x))
            (exec-path-from-shell-initialize)))

;; Load doom theme
(use-package doom-themes :ensure t
    :config
    (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
            doom-themes-enable-italic t) ; if nil, italics is universally disabled
    (load-theme 'doom-nord t)  ;; Set theme

    ;; Enable flashing mode-line on errors
    ;; (doom-themes-visual-bell-config)

    ;; Enable custom neotree theme (all-the-icons must be installed!)
    (doom-themes-neotree-config)
    ;; or for treemacs users
    (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
    (doom-themes-treemacs-config)

    ;; Corrects (and improves) org-mode's native fontification.
    (doom-themes-org-config))

;; Enable all-the-icons
(use-package all-the-icons :ensure t)

;; Doom-modeline
(use-package doom-modeline
    :ensure t
    :hook (after-init . doom-modeline-mode)
    :config
    ;; Explicitly enable doom-modeline icons such that they are also displayed
    ;; in emacs daemon mode
    (column-number-mode +1)
    (setq doom-modeline-icon t)
    (setq doom-modeline-buffer-file-name-style 'relative-from-project)
    (setq doom-modeline-env-python-executable "python") ; or `python-shell-interpreter'
    (setq doom-modeline-env--command-args "--version"))


;; General keybindings
(use-package general
    :config
    (general-evil-setup))

;; Enable projectile
(use-package projectile
  :ensure t
  :init
  (setq projectile-require-project-root nil)
  :config
  (projectile-mode 1))


;; Additional packages
(use-package expand-region)
(use-package xclip
  :init
  (xclip-mode t))
(use-package origami)
(use-package rainbow-mode)
(use-package direnv)
(use-package avy)
(use-package graphviz-dot-mode)
(use-package hl-todo)
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
(use-package winum
  :init (winum-mode))
;; (use-package atomic-chrome)
(use-package edit-server
    :config
    ;; Set server port
    (setq edit-server-port 9292)

    ;; If this is an emacs-daemon, start the edit-server
    (when (daemonp)
      (edit-server-start))
    )
(use-package posframe)
(use-package csv-mode
  :config
    (add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
    (autoload 'csv-mode "csv-mode"
    "Major mode for editing comma-separated value files." t)
  )


;; Enable flyspell mode during latex mode
(add-hook 'LaTeX-mode-hook 'flyspell-mode)

;; Make ESC behave like C-g
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

;;;;;;; Todo: move somewhere else?
;; Needs terminal-notifier (brew install terminal-notifier)
(defun slang/notify-send (title message)
(call-process "notify-send"
                nil 0 nil
                title
                message
                "--expire-time" "300000" ; 5 minutes
                "--app-name" "Emacs"
                ))

;; Disable follow symlinks warning
(setq vc-follow-symlinks nil)

(load-file (concat emacs-dir "keybindings.el"))

(provide 'init)
;;; init.el ends here
