(use-package lsp-mode
  :hook (python-mode . lsp-deferred)
  :commands lsp-deferred)

(use-package lsp-ui
    :commands lsp-ui-mode
    :config
    ;; Disable lsp-ui-doc-mode
    (add-hook 'lsp-ui-mode-hook (lambda () (lsp-ui-doc-mode -1))))
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode
    :after (lsp-mode)
    :hook ((dap-ui-sessions-mode . evil-evilified-state)
           (dap-ui-breakpoints-ui-list-mode . evil-evilified-state)
           (dap-ui-locals-mode . evil-evilified-state)
           (dap-ui-inspect-mode . evil-evilified-state))
    :config
    (progn
      (dap-mode 1)
      (dap-ui-mode 1)))

(defun slang/add-dap-keybindings (mode-map)
  "Add the dap keybindings do the given mode-map.
   This is supposed to be called from layer/<language>/config-post.el"
      
      ;; key bindings

        ;; (spacemacs/declare-prefix-for-mode mode "md" "debug")
        ;; (spacemacs/declare-prefix-for-mode mode "mdb" "breakpoints")
        ;; (spacemacs/declare-prefix-for-mode mode "mdd" "debugging")
        ;; (spacemacs/declare-prefix-for-mode mode "mde" "eval")
        ;; (spacemacs/declare-prefix-for-mode mode "mdI" "inspect")
        ;; (spacemacs/declare-prefix-for-mode mode "mdS" "switch")
        ;; (spacemacs/declare-prefix-for-mode mode "mdT" "toggles")
        ;; (spacemacs/declare-prefix-for-mode mode "mdw" "debug windows")

      (general-def mode-map
        :states '(normal emacs visual)
        :prefix ","
          ;; transient state
          "d."  'dap-hydra
          ;; repl
          "d'"  'dap-ui-repl
          ;; abandon
          "da"  'dap-disconnect
          "dA"  'dap-delete-all-sessions
          ;; breakpoints
          "dbb" 'dap-breakpoint-toggle
          "dbc" 'dap-breakpoint-condition
          "dbl" 'dap-breakpoint-log-message
          "dbh" 'dap-breakpoint-hit-condition
          "dba" 'dap-breakpoint-add
          "dbd" 'dap-breakpoint-delete
          "dbD" 'dap-breakpoint-delete-all
          ;; debuging/running
          "ddd" 'dap-debug
          "dde" 'dap-debug-edit-template
          "ddl" 'dap-debug-last
          "ddr" 'dap-debug-recent
          ;; eval
          "dee" 'dap-eval
          "der" 'dap-eval-region
          "det" 'dap-eval-thing-at-point
          ;; inspect
          "dIi" 'dap-ui-inspect
          "dIr" 'dap-ui-inspect-region
          "dIt" 'dap-ui-inspect-thing-at-point
          ;; stepping
          "dc"  'dap-continue
          "di"  'dap-step-in
          "do"  'dap-step-out
          "dr"  'dap-restart-frame
          "ds"  'dap-next
          "dv"  'dap-ui-inspect-thing-at-point
          ;; switching
          "dSs" 'dap-switch-session
          "dSt" 'dap-switch-thread
          "dSf" 'dap-switch-frame
          ;; windows
          "dwo" 'dap-go-to-output-buffer
          "dwl" 'dap-ui-locals
          "dws" 'dap-ui-sessions
          "dwb" 'dap-ui-breakpoints))
