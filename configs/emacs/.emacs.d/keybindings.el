(defmacro general-global-menu-definer (def infix-key &rest body)
  "Create a definer named general-global-DEF wrapping global-definer.
The prefix map is named 'my-DEF-map'."
  `(progn
     (general-create-definer ,(intern (concat "general-global-" def))
       :wrapping global-definer
       :prefix-map (quote ,(intern (concat "my-" def "-map")))
       :infix ,infix-key
       :wk-full-keys nil
       "" '(:ignore t :which-key ,def))
     (,(intern (concat "general-global-" def))
      ,@body)))

;; To start I created a global-definer with general's general-create-definer macro to set up the global SPC prefix:
(global-unset-key (kbd "C-SPC"))
(general-create-definer global-definer
  :keymaps 'override
  :states '(insert emacs normal hybrid motion visual operator)
  :prefix "SPC"
  :non-normal-prefix "C-SPC")

(global-definer
    ;; General stuff
    "!"   'shell-command
    ":"   'eval-expression
    "/"   'helm-do-ag-project-root
    "TAB" '((lambda () (interactive) (switch-to-buffer nil))
            :which-key "other-buffer")
    "SPC" 'helm-M-x
    "qq"  'save-buffers-kill-terminal
    "'"   'ansi-term
    "v"   'er/expand-region

    ;; Window selection
    "1"   'winum-select-window-1
    "2"   'winum-select-window-2
    "3"   'winum-select-window-3
    "4"   'winum-select-window-4
    "5"   'winum-select-window-5
    "6"   'winum-select-window-6
    "7"   'winum-select-window-7
    "8"   'winum-select-window-8
    "9"   'winum-select-window-9)


;; Files
(general-global-menu-definer
    "files" "f"
    "f"  'helm-find-files
    "ed"  'slang/edit-config
    "er"  'slang/reload-config)


;; Magit
(general-global-menu-definer
    "git" "g"
    "s"   'magit-status)


;; Buffers
(general-global-menu-definer
    "buffers" "b"
    "b"  'helm-buffers-list
    "s"  'slang/switch-to-scratch
    "M" '((lambda () (interactive) (switch-to-buffer "*Messages*"))
        :which-key "messages-buffer")
    "d"  'kill-this-buffer)

;; Window
(general-global-menu-definer
    "windows" "w"
    "l"  'windmove-right
    "h"  'windmove-left
    "k"  'windmove-up
    "j"  'windmove-down
    "m"  'toggle-maximize-buffer
    "/"  'split-window-right
    "-"  'split-window-below
    "d"  'delete-window)

;; Projectile
(general-global-menu-definer
 "projectile" "p"
    "p"  'helm-projectile-switch-project
    "b"  'helm-projectile-switch-to-buffer
    "f"  'helm-projectile-find-file
    "/"  'helm-projectile-ag)


;; Zetteldeft
(general-global-menu-definer
    "zetteldeft" "d"
    "d" 'slang/zetteldeft-new-search-other-window
    "R" 'deft-refresh
    "s" 'zetteldeft-search-at-point
    "c" 'zetteldeft-search-current-id
    "f" 'zetteldeft-follow-link
    "F" 'zetteldeft-avy-file-search-ace-window
    "l" 'zetteldeft-avy-link-search
    "t" 'zetteldeft-avy-tag-search
    "T" 'zetteldeft-tag-buffer
    "i" 'zetteldeft-find-file-id-insert
    "I" 'zetteldeft-find-file-full-title-insert
    "o" 'zetteldeft-find-file
    "n" 'zetteldeft-new-file
    "N" 'zetteldeft-new-file-and-link
    "r" 'zetteldeft-file-rename
    "x" 'zetteldeft-count-words
    "y" 'zetteldeft-copy-id-current-file
    "L" 'zetteldeft-insert-list-links)


;; Text scaling
(general-global-menu-definer
    "text" "x"
    "a" 'text-scale-adjust)

