(use-package pyvenv
  :hook python-mode)

(defun slang/pyvenv-activate ()
  "Wrapper for pyvenv-activate that also restarts the lsp-sessions."
  (interactive)
  (call-interactively 'pyvenv-activate)
  (call-interactively 'lsp-restart-workspace))
