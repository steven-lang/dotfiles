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


;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)

(setq org-directory "~/org/")

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

;; Disable auto-fill-mode
;; (remove-hook 'text-mode-hook #'auto-fill-mode)
;; (add-hook 'latex-mode-hook #'auto-fill-mode)
(add-hook 'TeX-mode-hook #'auto-fill-mode)

;; Enable word wrap mode
(+global-word-wrap-mode)

;; Company config
(setq
 ;; company-minimum-prefix-length 1
 company-idle-delay 0.1
 company-tooltip-idle-delay 0.1)

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
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-env-python-executable "python") ; or `python-shell-interpreter'

;; Keybindings
(load!  "keybindings.el")


;; Use offlineimap as mu4e backend
;; (add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
;; (setq +mu4e-backend 'offlineimap)
;; (setq +mu4e-mu4e-mail-path "~/.mail")
;; (setq mu4e-get-mail-command "offlineimap -o")
;; (set-email-account! "GMail steven.lang.mz"
;;                     '((mu4e-sent-folder       . "/[Gmail].Sent Mail")
;;                       (mu4e-drafts-folder     . "/[Gmail].Drafts")
;;                       (mu4e-trash-folder      . "/[Gmail].Trash")
;;                       (mu4e-update-interval   . 300)
;;                       (smtpmail-smtp-user     . "steven.lang.mz@gmail.com")
;;                       (smtpmail-default-smtp-server . "smtp.gmail.com")
;;                       (smtpmail-smtp-server . "smtp.gmail.com")
;;                       (smtpmail-smtp-service . 587)
;;                       (smtpmail-local-domain . "gmail.com")
;;                       ;; (smtpmail-auth-credentials . (expand-file-name "~/.authinfo.gpg"))
;;                       (user-mail-address      . "steven.lang.mz@gmail.com"))
;;                     t)
;; (setq mu4e-update-interval 300)
;; (setq message-send-mail-function 'smtpmail-send-it
;;       starttls-use-gnutls t
;;       smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials
;;       '(("smtp.gmail.com" 587 "steven.lang.mz@gmail.com" nil))
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587)

;; Add action to view in browser
;; (add-to-list 'mu4e-view-actions
;;              '("View in Browser" . mu4e-action-view-in-browser) t)

;; (use-package! mu4e-alert
;;   :after mu4e
;;   :init
;;   (setq mu4e-alert-interesting-mail-query "flag:unread maildir:/Gmail/INBOX")
;;   (mu4e-alert-set-default-style 'libnotify)
;;   (mu4e-alert-enable-notifications))

;; Set latex viewer
;; (setq +latex-viewers '(evince))
(setq +latex-viewers '(pdf-tools))

;; Let evince not steal focus
(setq TeX-view-evince-keep-focus t)


;; Set deft directory
(setq deft-directory "~/org/notes/")

;; Org setup
(after! org
  (load! "org-setup.el"))

;; Use aggressive indenting in emacs-lisp-mode
(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)

;; Make latex sections have a larger font
(setq font-latex-fontify-sectioning 1.3)

;; Langtool
(setq langtool-java-classpath
      "/usr/share/languagetool:/usr/share/java/languagetool/*")

(setq flycheck-flake8rc "~/.config/flake8")
(setq flycheck-python-flake8-executable "flake8")

;; For python
(add-hook 'python-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
;; (add-hook 'julia-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

;; Enable rainbow delimiters in prog mode
(use-package! rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; Set julia lsp environment
;; (use-package! lsp-julia
;;   :config
;;   (setq lsp-julia-default-environment "~/.julia/environments/v1.5")
;;   (setq lsp-enable-folding t)
;;   (setq lsp-folding-range-limit 100))

;; this macro was copied from here: https://stackoverflow.com/a/22418983/4921402
(defmacro define-and-bind-quoted-text-object (name key start-regex end-regex)
  (let ((inner-name (make-symbol (concat "evil-inner-" name)))
        (outer-name (make-symbol (concat "evil-a-" name))))
    `(progn
       (evil-define-text-object ,inner-name (count &optional beg end type)
         (evil-select-paren ,start-regex ,end-regex beg end type count nil))
       (evil-define-text-object ,outer-name (count &optional beg end type)
         (evil-select-paren ,start-regex ,end-regex beg end type count t))
       (define-key evil-inner-text-objects-map ,key #',inner-name)
       (define-key evil-outer-text-objects-map ,key #',outer-name))))

;; Add more textobjects
(define-and-bind-quoted-text-object "pipe" "|" "|" "|")
(define-and-bind-quoted-text-object "slash" "/" "/" "/")
(define-and-bind-quoted-text-object "star" "*" "*" "*")
(define-and-bind-quoted-text-object "dollar" "$" "\\$" "\\$") ;; sometimes your have to escape the regex


;; Bury compilation buffers if successful
;; (add-hook 'compilation-finish-functions 'slang/bury-compile-buffer-if-successful)


;; Set correct conda variables
(use-package! conda
  :after python
  :config
  (setq conda-env-home-directory (expand-file-name "~/.conda"))
  (custom-set-variables
   `(conda-anaconda-home ,(expand-file-name "~/.conda"))))

;; EMACS ANYWHERE
;; Define a function or use a lambda of the same signature
(defun popup-handler (app-name window-title x y w h)
  (markdown-mode))

;; Hook your function
(add-hook 'ea-popup-hook 'popup-handler)

;; Hide files in treemacs that are listed in .gitignore
;; (use-package! treemacs
;;   :config
;;   (treemacs-git-mode 'extended)
;;   (with-eval-after-load 'treemacs
;;     (add-to-list 'treemacs-pre-file-insert-predicates #'treemacs-is-file-git-ignored?)))

;; Python docstring tool
(use-package! py-pyment
  :after python
  :config
  (setq py-pyment-options '("--output=google")))

;; Make evil substute (:s/foo/bar/) global by default (-> s/foo/bar/g)
(use-package! evil
  :config
  (setq evil-ex-substitute-global t))


;; Fix doom modeline icons (only issue on arch emacs binary)
(custom-set-faces!
  ;; Flycheck check symbol and sim-card symbol (right-hand side)
  '(doom-modeline-warning :inherit warning)
  '(doom-modeline-debug :inherit font-lock-doc-face :slant normal)

  ;; Insert/normal state (left-hand side)
  '(doom-modeline-evil-emacs-state :inherit font-lock-builtin-face)
  '(doom-modeline-evil-insert-state :inherit font-lock-keyword-face)
  '(doom-modeline-info :inherit success)
  )

(defun slang/enable-pdf-view-midnight-minor-mode ()
  (pdf-view-midnight-minor-mode))

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


;; pdf-tools midnight colors
(use-package! pdf-tools
  :defer
  :config
  ;; (setq pdf-view-midnight-colors '("#ffffff" . "#000000"))  ;; black-white
  (setq pdf-view-midnight-colors '("#282c34" . "#bbc2cf"))  ;; doom-one
  )
