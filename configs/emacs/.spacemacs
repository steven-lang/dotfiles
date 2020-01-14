;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.


(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(javascript
     vimscript
     html
     csv
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     helm
     (auto-completion :variables
                      spacemacs-default-company-backends '(company-files  company-capf)
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-enable-help-tooltip t
                      auto-completion-enable-sort-by-usage t)
     ;; better-defaults ;; emacs binding specifics
     emacs-lisp
     git
     markdown
     ;; multiple-cursors
     ;; treemacs
     org

     (shell :variables
            shell-default-term-shell "/bin/zsh"
            multi-term-program "/bin/zsh"
            shell-default-height 30
            shell-default-position 'bottom
            shell-scripts-backend 'lsp)
     (spell-checking :variables
                     enable-flyspell-auto-completion nil
                     spell-checking-enable-auto-dictionary t
                     spell-checking-enable-by-default nil
                     )
     syntax-checking
     (version-control :variables
                      version-control-diff-tool 'diff-hl
                      version-control-global-margin t)
     themes-megapack
     (python :variables
             python-backend 'lsp
             python-lsp-server 'mspyls
             ;; python-lsp-git-root "~/python-language-server"
             )

     ;; ipython-notebook
     (gtags :variables gtags-enable-by-default t)
     (latex :variables latex-enable-auto-fill t)

     pdf

     ;; C++ and C support
     (c-c++ :variables =c-c++-backend= 'lsp-clangd)

     ;; CUDA support
     gpu

     ;; Prolog support
     prolog

     ;; Julia support 
     ;; (julia :variables julia-mode-enable-lsp t)

     ;; Deft support
     deft
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(ssh-agency
                                      org-ql
                                      org-super-agenda
                                      org-gcal
                                      org-ref
                                      origami
                                      rainbow-mode
                                      direnv
                                      zetteldeft
                                      graphviz-dot-mode)

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; File path pointing to emacs 27.1 executable compiled with support
   ;; for the portable dumper (this is currently the branch pdumper).
   ;; (default "emacs-27.0.50")
   dotspacemacs-emacs-pdumper-executable-file "emacs-27.0.50"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives nil

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner nil

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7)
                                (todos . 5))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(doom-nord
                         solarized-light
                         gruvbox-dark-soft
                         atom-one-dark
                         spacemacs-dark
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   ;; dotspacemacs-mode-line-theme '(doom :separator wave :separator-scale 1.5)
   dotspacemacs-mode-line-theme '(doom)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   ;; dotspacemacs-default-font '("Source Code Pro"
   dotspacemacs-default-font '("Hack"
                               :size 15
                               :weight normal
                               :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers 'relative

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env)
  )

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  (setq-default git-magit-status-fullscreen t)
  )

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."

  ;; Fix emacs font when used in daemon mode, see  https://stackoverflow.com/questions/3984730/emacs-gui-with-emacs-daemon-not-loading-fonts-correctly
  ;; (add-to-list 'default-frame-alist '(font . "Hack 15"))
  (when (display-graphic-p)
    (set-face-attribute 'default nil :font "Hack 15"))

  (with-eval-after-load 'org
    ;; here goes your Org config :)
    (add-hook 'org-mode-hook 'electric-pair-mode)

    (require 'org-super-agenda)
    (org-super-agenda--def-auto-group outline-path "their outline paths"
      :key-form (org-super-agenda--when-with-marker-buffer (org-super-agenda--get-marker item)
                  (s-join " | " (org-get-outline-path))))

    ;; Bigger latex fragments
    (plist-put org-format-latex-options :scale 2)

    ;; Default org file when using capture (C-c c)
    (setq org-default-notes-file "~/Dropbox/orgmode/gtd/inbox.org")

    ;; Org agenda files: look for all files in the following directory
    (setq org-agenda-files
      (quote ("~/Dropbox/orgmode/gtd")))

    ;; Org-Capture Templates
    (setq org-capture-templates
          '(;; Todo entries
            ("t"
             "Todo"
             entry
             (file+headline org-default-notes-file "Inbox")
             "** TODO %?\n:PROPERTIES:\n:CREATED:\t%u\n:END:\n"
             ;; :clock-in t
             ;; :clock-resume t
             :empty-lines 1)
          ))


    ;; Set the org refile targets to org agenda files
    (setq org-refile-targets (quote ((nil :maxlevel . 9)
                                    (org-agenda-files :maxlevel . 2))))

    ;; Set default column view headings: Task Total-Time Time-Stamp
    ;; (setq org-columns-default-format "%50ITEM(Task) %10CLOCKSUM %16TIMESTAMP_IA")

    (defun jethro/switch-to-agenda ()
      (interactive)
      (org-agenda nil "a")
      (delete-other-windows))

    (setq org-agenda-window-setup 'reorganize-frame)

    ;; Set f1 to open agenda
    (bind-key "<f1>" 'jethro/switch-to-agenda)

    ;; Set org-done face
    ;; (org-done ((t (:strike-through t :weight bold))))

    ;; Set org-columns view default format (activate in agenda view with ", c")
    (setq org-columns-default-format "%40ITEM(Task) %Effort(EE){:} %CLOCKSUM(Time Spent) %SCHEDULED(Scheduled) %DEADLINE(Deadline)")

    ;; Org-Mode todo keywords
    (setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "WAITING(w)" "|" "DONE(d)" "CANCELED(c)")))

    ;; To permanently enable mode line display of org clock
    (setq spaceline-org-clock-p t)

    ;; Set todo keyword colors
    (setq org-todo-keyword-faces
          '(
            ("TODO"      :foreground "#99c794" :weight bold)
            ("STARTED"   :foreground "#fac863" :weight bold)
            ("NEXT"      :foreground "#5fb3b3" :weight bold)
            ("WAITING"   :foreground "#6699cc" :weight bold)
            ;; ("UNCERTAIN" :foreground "#c594c5" :weight bold)
            ("DONE"      :foreground "#4f5b66" :weight bold)
            ("CANCELED"  :foreground "#ec5f67" :weight bold)
            )
          )

    ;; Disable TODO and DONE highlighting in org mode
    (add-hook 'org-mode-hook (lambda () (hl-todo-mode -1)))
    (add-hook 'org-mode-hook (lambda () (org-indent-mode t)))

    ;; Save buffer on clocking in/out
    (add-hook 'org-clock-in-hook #'save-buffer)
    (add-hook 'org-clock-out-hook #'save-buffer)


    ;; org-pomodoro
    ;; (setq org-pomodoro-clock-break t)

    ;; org-pomodoro mode hooks
    (add-hook 'org-pomodoro-finished-hook
              (lambda ()
                (notify-send "Pomodoro completed!" "Time for a break.")))

    (add-hook 'org-pomodoro-break-finished-hook
              (lambda ()
                (notify-send "Pomodoro Short Break Finished" "Ready for Another?")))

    (add-hook 'org-pomodoro-long-break-finished-hook
              (lambda ()
                (notify-send "Pomodoro Long Break Finished" "Ready for Another?")))

    (add-hook 'org-pomodoro-killed-hook
              (lambda ()
                (notify-send "Pomodoro Killed" "One does not simply kill a pomodoro!")))


    (setq org-tag-alist
          '(
            ("@work" . ?w)
            ("@studying" . ?s)
            ("@home" . ?h)
            ("@freetime" . ?f)
            )
          )
    ;; Disable super-agenda keymap (breaks evil up/down on headers)
    (setq org-super-agenda-header-map (make-sparse-keymap))

    ;; Set org agenda todo view (open with <f1>)
    (setq slang/org-agenda-directory "~/Dropbox/orgmode/gtd/")
    (setq slang/org-agenda-todo-view
          `("a" "Full Agenda"
            ((agenda ""
                  ((org-agenda-span '14)
                   ;; (org-super-agenda-groups '((:auto-parent t)))
                    (org-deadline-warning-days 365)))

            ;; To be refiled
            (todo "TODO"
                  ((org-agenda-overriding-header "To Refile")
                   (org-agenda-files '(,(concat slang/org-agenda-directory "inbox.org")))))

            ;; Next Actions Category
            (alltodo ""
                     ((org-agenda-overriding-header "Next Actions")
                      (org-super-agenda-groups '((:discard (:not (:todo "NEXT")))
                                                 (:auto-outline-path t)))
                      (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))

            ;; Waiting for category
            (alltodo ""
                     ((org-agenda-overriding-header "Waiting For")
                      (org-super-agenda-groups '((:discard (:not (:todo "WAITING")))
                                                 (:auto-outline-path t)))
                      (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))

            ;; All in progress
            (alltodo ""
                  ((org-agenda-overriding-header "Projects")
                   (org-super-agenda-groups '(
                                              (:discard (:tag "someday")) ;; Don't show todos tagged with "someday"
                                              (:discard (:habit t)) ;; Don't show habits
                                              (:discard (:todo "WAITING")) ;; Don't show waiting
                                              (:discard (:todo "NEXT")) ;; Don't show waiting
                                              (:auto-outline-path t)
                                              ))
                   (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))


            (tags "someday" ;; Only show those tagged with someday
                  ((org-agenda-overriding-header "Someday/Maybe")
                   (org-super-agenda-groups '(
                                              (:discard (:todo "DONE"))
                                              (:discard (:todo "CANCELED"))
                                              (:auto-outline-path t)))
                   (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))

            (alltodo ""
                     ((org-agenda-overriding-header "Reference Material")
                      (org-super-agenda-groups '((:auto-outline-path t)))
                      (org-agenda-files '(,(concat slang/org-agenda-directory "reference-material.org")))))
            )
            nil
            ("/tmp/org-agenda.html")))

    (setq slang/org-agenda-lower-eq-10-mins-view
          `("l" "Less than 10 minutes effort"
            (
             (agenda ""
                     ((org-agenda-span 'day)
                      (org-super-agenda-groups '(
                                                 (:discard (:effort> "11"))
                                                 (:auto-parent t)))
                      (org-deadline-warning-days 365)))
             (alltodo ""
                      ((org-agenda-overriding-header "Less than 10 minutes effort")
                       (org-super-agenda-groups '((:discard (:effort> "11"))
                                                  (:discard (:habit t))
                                                  (:auto-parent t)))
                       (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))
                       )))


    (defun slang/make-org-agenda-custom-view (tag key description)
      "Make a custom agenda view filtered by a specific context tag."
        `(,key ,description
           (

            ;; Next Actions Category
            (alltodo ""
                     ((org-agenda-overriding-header "Next Actions")
                      (org-super-agenda-groups '((:discard (:not (:todo "NEXT")))
                                                 (:discard (:not (:tag ,tag)))
                                                 (:auto-outline-path t)))
                      (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))

            ;; Waiting for category
            (alltodo ""
                     ((org-agenda-overriding-header "Waiting For")
                      (org-super-agenda-groups '((:discard (:not (:todo "WAITING")))
                                                 (:discard (:not (:tag ,tag)))
                                                 (:auto-outline-path t)))
                      (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))

            ;; Projects
            (alltodo ""
                     ((org-agenda-overriding-header ,description)
                      (org-super-agenda-groups '((:discard (:habit t))
                                                 (:discard (:not (:tag ,tag)))
                                                 (:discard (:todo "WAITING"))
                                                 (:discard (:todo "NEXT"))
                                                 (:discard (:tag "someday"))
                                                 (:auto-outline-path t)))
                      (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))
         )))
    
    ;; (setq org-agenda-custom-commands
    ;;       '(("X" agenda "" nil ("agenda.html"))))
    ;; (setq org-agenda-custom-commands (list))
    ;; ;; Set to empty list is necessary or else org-agenda-custom-commands is not defined
    (setq org-agenda-custom-commands (list))
    (add-to-list 'org-agenda-custom-commands `,slang/org-agenda-todo-view)
    (add-to-list 'org-agenda-custom-commands `,slang/org-agenda-lower-eq-10-mins-view)
    (add-to-list 'org-agenda-custom-commands `,(slang/make-org-agenda-custom-view "@work" "cw" "At Work"))
    (add-to-list 'org-agenda-custom-commands `,(slang/make-org-agenda-custom-view "@home" "ch" "At Home"))
    (add-to-list 'org-agenda-custom-commands `,(slang/make-org-agenda-custom-view "@studying" "cs" "At Studying"))
    (add-to-list 'org-agenda-custom-commands `,(slang/make-org-agenda-custom-view "@freetime" "cf" "At Free Time"))

    (defvar slang/org-current-effort "1:00" "Current effort for agenda items.")

    (defun slang/my-org-agenda-set-effort (effort)
      "Set the effort property for the current headline."
      (interactive
      (list (read-string (format "Effort [%s]: " slang/org-current-effort) nil nil slang/org-current-effort)))
      (setq slang/org-current-effort effort)
      (org-agenda-check-no-diary)
      (let* ((hdmarker (or (org-get-at-bol 'org-hd-marker)
                          (org-agenda-error)))
            (buffer (marker-buffer hdmarker))
            (pos (marker-position hdmarker))
            (inhibit-read-only t)
            newhead)
        (org-with-remote-undo buffer
                              (with-current-buffer buffer
                                (widen)
                                (goto-char pos)
                                (org-show-context 'agenda)
                                (funcall-interactively 'org-set-effort nil slang/org-current-effort)
                                (end-of-line 1)
                                (setq newhead (org-get-heading)))
                              (org-agenda-change-all-lines newhead hdmarker))))



    ;; Process a single inbox item:
    ;; 1) Set tags
    ;; 2) Set priority
    ;; 3) Estimate effort
    ;; 4) Refile
    (defun slang/org-agenda-process-inbox-item ()
      "Process a single item in the org-agenda."
      (interactive)
      (org-with-wide-buffer
       (org-agenda-todo)
       (org-agenda-set-tags)
       (org-agenda-priority)
       (call-interactively 'slang/my-org-agenda-set-effort)
       (org-agenda-refile nil nil t)))

    ;; Export agenda to html file
    ;; TODO: Send via telegram or upload to server
    (defun slang/org-agenda-export ()
      (interactive)
      (org-agenda-write "~/Dropbox/orgmode/gtd/export/agenda.html")
      )

    ;; Define custom agenda keybindings
    (add-hook 'org-agenda-mode-hook (lambda ()
      (progn
        (org-super-agenda-mode t)
        (define-key org-agenda-mode-map "I" 'org-agenda-clock-in)
        (define-key org-agenda-mode-map "O" 'org-agenda-clock-out)
        (define-key spacemacs-org-agenda-mode-map (kbd "p") 'slang/org-agenda-process-inbox-item)
        (define-key spacemacs-org-agenda-mode-map (kbd "e") 'slang/org-agenda-export)
        (define-key spacemacs-org-agenda-mode-map (kbd "c") 'org-agenda-columns))))

    ;; org-gcal settings
    ;; TODO read from file
    (setq org-gcal-client-id "508241169276-aiegc8m0nnv45llkc9h4g8jp96gj96op.apps.googleusercontent.com"
          org-gcal-client-secret "bWGYW-3pEZsiu_-IyjTdm93a"
          org-gcal-file-alist '(("steven.lang.mz@gmail.com" .  "~/Dropbox/orgmode/gtd/calendar.org")))


    ;; Custom faces
    (custom-set-faces
     '(org-agenda-structure ((t (:foreground "#ECEFF4" :box (:line-width 1 :style released-button) :weight ultra-bold :height 1.5))))
     '(org-level-1 ((t (:inherit outline-1 :height 1.3))))
     '(org-level-2 ((t (:inherit outline-2 :height 1.25))))
     '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
     '(org-level-4 ((t (:inherit outline-4 :height 1.15))))
     '(org-level-5 ((t (:inherit outline-5 :height 1.1))))
     '(org-super-agenda-header ((t (:inherit org-agenda-structure :box nil :height 0.8)))))

    (custom-set-variables
     '(org-agenda-prefix-format
       '((agenda . "  %t ")
         (todo . "  • ")
         (tags . "  • ")
         (search . "  • ")))
     '(org-modules
       '(ol-bbdb ol-bibtex ol-docview ol-eww ol-gnus ol-info ol-irc ol-mhe org-protocol ol-rmail ol-w3m org-habit org-ql))
     '(org-priority-faces '((66 . "#f99157") (67 . "#65737e")))
     '(org-super-agenda-mode t)
     )

    ;; Org babel
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((dot . t)))
    (add-to-list 'org-src-lang-modes
                 '("dot" . graphviz-dot-mode))


    ;; Enable latex previews on kbd "lp"
    (define-key spacemacs-org-mode-map (kbd "lp") 'org-latex-preview)

    ;; Org-ref setup
    (require 'org-ref)
    (setq org-ref-default-bibliography "~/Dropbox/orgmode/bibliography/references.bib"
          org-ref-pdf-directory "~/pdf/"
          bibtex-completion-bibliography "~/Dropbox/orgmode/bibliography/references.bib"
          bibtex-completion-library-path "~/Dropbox/orgmode/bibliography/bibtex-pdfs"
          bibtex-completion-notes-path "~/Dropbox/orgmode/bibliography/helm-bibtex-notes")


    ;; End org hook
    )

  ;; Deft config
  (setq deft-directory "~/Dropbox/orgmode/notes/"
        deft-recursive t)

  ;; Zetteldeft config
  (require 'zetteldeft)


  ;; (if other
  ;;     (if switch
  ;;         (switch-to-buffer-other-window buffer)
  ;;       (display-buffer buffer other))
  ;;   (switch-to-buffer buffer))
  (defun slang/deft-other-window ()
    (interactive)
    (split-window-sensibly)
    (other-window 1)
    (deft)
    (evil-insert 1))

  (defun slang/zetteldeft-new-search-other-window ()
    (interactive)
    (split-window-sensibly)  ;; open in other window 
    (other-window 1)  ;; Switch to next window
    (zetteldeft-deft-new-search)  ;; Open deft new search
    (goto-line 3)  ;; Set cursor to second line (first results)
    (evil-insert 1))  ;; Enter insert mode

  (spacemacs/declare-prefix "d" "deft")

  ;; (spacemacs/set-leader-keys "dd" 'slang/deft-other-window)
  (spacemacs/set-leader-keys "dd" 'slang/zetteldeft-new-search-other-window)
  (spacemacs/set-leader-keys "dR" 'deft-refresh)
  ;; (spacemacs/set-leader-keys "dD" 'slang/zetteldeft-new-search-other-window)
  (spacemacs/set-leader-keys "ds" 'zetteldeft-search-at-point)
  (spacemacs/set-leader-keys "dc" 'zetteldeft-search-current-id)
  (spacemacs/set-leader-keys "df" 'zetteldeft-follow-link)
  (spacemacs/set-leader-keys "dF" 'zetteldeft-avy-file-search-ace-window)
  (spacemacs/set-leader-keys "dl" 'zetteldeft-avy-link-search)
  (spacemacs/set-leader-keys "dt" 'zetteldeft-avy-tag-search)
  (spacemacs/set-leader-keys "dT" 'zetteldeft-tag-buffer)
  (spacemacs/set-leader-keys "di" 'zetteldeft-find-file-id-insert)
  (spacemacs/set-leader-keys "dI" 'zetteldeft-find-file-full-title-insert)
  (spacemacs/set-leader-keys "do" 'zetteldeft-find-file)
  (spacemacs/set-leader-keys "dn" 'zetteldeft-new-file)
  (spacemacs/set-leader-keys "dN" 'zetteldeft-new-file-and-link)
  (spacemacs/set-leader-keys "dr" 'zetteldeft-file-rename)
  (spacemacs/set-leader-keys "dx" 'zetteldeft-count-words)
  (spacemacs/set-leader-keys "dy" 'zetteldeft-copy-id-current-file)
  (spacemacs/set-leader-keys "dL" 'zetteldeft-insert-list-links)


  ;; Add title suffix
  (setq zetteldeft-title-suffix "
#+OPTIONS: toc:nil num:0
#+STARTUP: latexpreview showall

* 


* References
")

  ;; Open preview
  (defun efls/deft-open-preview ()
    (interactive)
    (deft-open-file-other-window))
  ;; Open other window
  (defun efls/deft-open-other ()
    (interactive)
    (deft-open-file-other-window t))

  (with-eval-after-load 'deft
    (define-key deft-mode-map
      (kbd "<tab>") 'efls/deft-open-preview)
    (define-key deft-mode-map
      (kbd "<s-return>") 'efls/deft-open-other)
    (define-key deft-mode-map
      (kbd "s-j") 'evil-next-line)
    (define-key deft-mode-map (kbd "s-k") 'evil-previous-line))


  ;; Enable company auto completion everywhere
  (global-company-mode t)

  ;; ???
  (add-hook 'doc-view-mode-hook 'auto-revert-mode)


  ;; Enable global visual line
  (global-visual-line-mode 1)

  ;; Set julia tab offset
  (setq julia-indent-offset 2)

  ;; Overwrite SPC j w with jump to word (without characters)
  (define-key evil-normal-state-map (kbd "s") 'avy-goto-char-2)

  ;; Enable flyspell mode during latex mode
  (add-hook 'LaTeX-mode-hook 'flyspell-mode)

  ;; Nice company faces
  (custom-set-faces
   '(company-tooltip-common
     ((t (:inherit company-tooltip :weight bold :underline nil))))
   '(company-tooltip-common-selection
     ((t (:inherit company-tooltip-selection :weight bold :underline nil))))
   )

  ;; Needs terminal-notifier (brew install terminal-notifier)
  (defun notify-send (title message)
    (call-process "notify-send"
                  nil 0 nil
                  title
                  message
                  "--expire-time" "300000" ; 5 minutes
                  "--app-name" "Emacs"
                  ))


  ;; Golden ration for layouts
  (golden-ratio-mode t)


  ;; Disable scroll bar
  (scroll-bar-mode -1)

  ;; Explicitly enable doom-modeline icons such that they are also displayed
  ;; in emacs daemon mode
  (setq doom-modeline-icon t)
  (setq doom-modeline-buffer-file-name-style 'relative-from-project)
  (setq doom-modeline-env-python-executable "python") ; or `python-shell-interpreter'
  (setq doom-modeline-env--command-args "--version")

  ;; Disable follow symlinks warning
  (setq vc-follow-symlinks nil)

  ;; Run org-gcal-fetch every 3 hours
  ;; (run-with-timer 0 (* 60 180) (progn
  ;;                                (message "Synced org-gcal")
  ;;                                'org-gcal-fetch
  ;;                                ))

  ;; Disable lsp-ui-doc-mode
  (add-hook 'lsp-ui-mode-hook (lambda () (lsp-ui-doc-mode -1)))


  ;; Org agenda save
  (defun slang/org-agenda-export-and-scp ()
    (interactive)
    (progn
      (org-store-agenda-views)
      (shell-command "scp -i ~/.ssh/id_rsa_mz /tmp/org-agenda.html rpi:org-agenda/")
      ))

)


;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(compilation-message-face 'default)
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes
   '("585942bb24cab2d4b2f74977ac3ba6ddbd888e3776b9d2f993c5704aa8bb4739" "8e797edd9fa9afec181efbfeeebf96aeafbd11b69c4c85fa229bb5b9f7f7e66c" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default))
 '(evil-want-Y-yank-to-eol nil)
 '(fci-rule-color "#eee8d5")
 '(helm-completion-style 'emacs)
 '(highlight-changes-colors '("#d33682" "#6c71c4"))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    '("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2")))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   '(("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100)))
 '(hl-bg-colors
   '("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342"))
 '(hl-fg-colors
   '("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3"))
 '(hl-paren-colors '("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900"))
 '(hl-todo-keyword-faces
   '(("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX" . "#dc752f")
     ("XXXX" . "#dc752f")))
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   '("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4"))
 '(org-agenda-prefix-format
   '((agenda . "  %t ")
     (todo . "  • ")
     (tags . "  • ")
     (search . "  • ")))
 '(org-highlight-latex-and-related '(latex script entities))
 '(org-modules
   '(ol-bbdb ol-bibtex ol-docview ol-eww ol-gnus ol-info ol-irc ol-mhe org-protocol ol-rmail ol-w3m org-habit org-ql))
 '(org-priority-faces '((66 . "#f99157") (67 . "#65737e")))
 '(org-super-agenda-mode t)
 '(package-selected-packages
   '(org-ref key-chord helm-bibtex biblio parsebib biblio-core helm-org ivy-rich wgrep smex ivy-yasnippet ivy-xref ivy-rtags ivy-purpose ivy-hydra flyspell-correct-ivy swiper-helm graphviz-dot-mode company-quickhelp deft direnv tern nodejs-repl livid-mode js2-refactor multiple-cursors js-doc import-js grizzl counsel-gtags all-the-icons-gnus all-the-icons-dired vimrc-mode dactyl-mode origami org-gcal rainbow-mode nord-theme ssh-agency opencl-mode lsp-treemacs lsp-python-ms helm-rtags helm-lsp helm-ls-git google-c-style glsl-mode flycheck-ycmd flycheck-rtags ediprolog disaster cuda-mode cquery cpp-auto-include company-ycmd ycmd request-deferred company-rtags rtags company-glsl company-c-headers clang-format ccls org-sidebar org-ql peg ov org-super-agenda ts ob-ipython ein skewer-mode polymode websocket js2-mode pdf-tools tablist dap-mode bui tree-mode lsp-python web-mode web-beautify tagedit slim-mode scss-mode sass-mode pug-mode prettier-js impatient-mode simple-httpd helm-css-scss haml-mode emmet-mode counsel-css company-web web-completion-data add-node-modules-path atomic-chrome jedi-core ede-php-autoload-composer-installers jedi company-jedi company-flx atom-one-dark-theme oceanic-theme evil-easymotion gmail-message-mode ham-mode html-to-markdown flymd edit-server csv-mode git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter flyspell-correct-helm flyspell-correct diff-hl browse-at-remote auto-dictionary lsp-ui company-lsp dracula-theme doom-themes django-theme darktooth-theme autothemer darkokai-theme darkmine-theme darkburn-theme dakrone-theme cyberpunk-theme color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized clues-theme cherry-blossom-theme busybee-theme bubbleberry-theme birds-of-paradise-plus-theme badwolf-theme apropospriate-theme anti-zenburn-theme ample-zen-theme ample-theme alect-themes afternoon-theme yasnippet-snippets yapfify xterm-color unfill smeargle shell-pop pyvenv pytest pyenv-mode py-isort pippel pipenv pip-requirements orgit org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-mime org-download org-brain mwim multi-term mmm-mode markdown-toc markdown-mode magit-svn magit-gitflow lsp-julia lsp-mode dash-functional live-py-mode julia-repl julia-mode importmagic epc ctable concurrent deferred htmlize helm-pydoc helm-org-rifle helm-gtags helm-gitignore helm-git-grep helm-company helm-c-yasnippet gnuplot gitignore-templates gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md ggtags fuzzy flycheck-pos-tip pos-tip flycheck evil-org evil-magit magit magit-popup git-commit with-editor eshell-z eshell-prompt-extras esh-help cython-mode company-statistics company-auctex company-anaconda company auto-yasnippet yasnippet auctex-latexmk auctex anaconda-mode pythonic ac-ispell auto-complete ws-butler writeroom-mode visual-fill-column winum volatile-highlights vi-tilde-fringe uuidgen treemacs-projectile treemacs-evil treemacs ht pfuture toc-org symon string-inflection spaceline-all-the-icons spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode password-generator paradox spinner overseer org-bullets open-junk-file nameless move-text macrostep lorem-ipsum link-hint indent-guide hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation helm-xref helm-themes helm-swoop helm-purpose window-purpose imenu-list helm-projectile helm-mode-manager helm-make helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state iedit evil-goggles evil-exchange evil-escape evil-ediff evil-cleverparens smartparens paredit evil-args evil-anzu anzu eval-sexp-fu elisp-slime-nav editorconfig dumb-jump doom-modeline eldoc-eval shrink-path all-the-icons memoize f dash s define-word counsel-projectile projectile counsel swiper ivy pkg-info epl column-enforce-mode clean-aindent-mode centered-cursor-mode auto-highlight-symbol auto-compile packed aggressive-indent ace-window ace-link ace-jump-helm-line helm avy helm-core popup which-key use-package pcre2el org-plus-contrib hydra font-lock+ evil goto-chg undo-tree dotenv-mode diminish bind-map bind-key async))
 '(pdf-view-midnight-colors '("#b2b2b2" . "#292b2e"))
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(tetris-x-colors
   [[229 192 123]
    [97 175 239]
    [209 154 102]
    [224 108 117]
    [152 195 121]
    [198 120 221]
    [86 182 194]])
 '(tooltip-mode t)
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   '((20 . "#dc322f")
     (40 . "#c8805d801780")
     (60 . "#bec073400bc0")
     (80 . "#b58900")
     (100 . "#a5008e550000")
     (120 . "#9d0091000000")
     (140 . "#950093aa0000")
     (160 . "#8d0096550000")
     (180 . "#859900")
     (200 . "#66aa9baa32aa")
     (220 . "#57809d004c00")
     (240 . "#48559e556555")
     (260 . "#392a9faa7eaa")
     (280 . "#2aa198")
     (300 . "#28669833af33")
     (320 . "#279993ccbacc")
     (340 . "#26cc8f66c666")
     (360 . "#268bd2")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   '(unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496"))
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil))))
 '(org-agenda-structure ((t (:foreground "#ECEFF4" :box (:line-width 1 :style released-button) :weight ultra-bold :height 1.5))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.3))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.25))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.15))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.1))))
 '(org-super-agenda-header ((t (:inherit org-agenda-structure :box nil :height 0.8)))))
)
