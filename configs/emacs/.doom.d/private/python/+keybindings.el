;;; ../dotfiles/configs/emacs/.doom.d/+modules/lang/python/keybindings.el -*- lexical-binding: t; -*-


;; DAP mode
(map! :localleader
      :map python-mode-map
      "d"   #'py-pyment-region

      (:prefix ("D" . "DAP")
       ;; transient state
       "."  #'dap-hydra

       ;; repl
       "d'"  #'dap-ui-repl

       ;; abandon
       "a"  #'dap-disconnect
       "A"  #'dap-delete-all-sessions

       ;; stepping
       "c"  #'dap-continue
       "i"  #'dap-step-in
       "o"  #'dap-step-out
       "r"  #'dap-restart-frame
       ;; "s"  #'dap-next
       "v"  #'dap-ui-inspect-thing-at-point

       ;; breakpoints
       (:prefix ("b" . "Breakpoints")
        "b" #'dap-breakpoint-toggle
        "c" #'dap-breakpoint-condition
        "l" #'dap-breakpoint-log-message
        "h" #'dap-breakpoint-hit-condition
        "a" #'dap-breakpoint-add
        "d" #'dap-breakpoint-delete
        "D" #'dap-breakpoint-delete-all)

       (:prefix ("d" . "Debug")
        ;; debuging/running
        "d" #'dap-debug
        "e" #'dap-debug-edit-template
        "l" #'dap-debug-last
        "r" #'dap-debug-recent)

       (:prefix ("e" . "Eval")
        ;; eval
        "e" #'dap-eval
        "r" #'dap-eval-region
        "t" #'dap-eval-thing-at-point)

       (:prefix ("I" . "Inspect")
        ;; inspect
        "i" #'dap-ui-inspect
        "r" #'dap-ui-inspect-region
        "t" #'dap-ui-inspect-thing-at-point)


       ;; switching
       (:prefix ("s" . "Switch")
        "s" #'dap-switch-session
        "t" #'dap-switch-thread
        "f" #'dap-switch-frame)

       (:prefix ("w" . "Windows")
        ;; windows
        "o" #'dap-go-to-output-buffer
        "l" #'dap-ui-locals
        "s" #'dap-ui-sessions
        "b" #'dap-ui-breakpoints)))



;; Make #'gd' call lsp-goto-definition
(map! :map python-mode-map
      :n "K"  #'+lookup/documentation
      :n "gr" #'+lookup/references
      :n "gd" #'+lookup/definition
      :n "C-k"  #'lsp-ui-doc-glance)


(map! :map python-mode-map
      :localleader
      ;; "v" #'slang/pyvenv-activate
      "v" #'slang/conda-env-activate
      ","  #'+format/buffer
      "s"  #'lsp-ivy-workspace-symbol
      ;; "s"  #'helm-lsp-workspace-symbol

      "b" #'slang/pdb-insert)
