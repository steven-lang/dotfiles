;;; ../dotfiles/configs/emacs/.doom.d/+modules/lang/python/functions.el -*- lexical-binding: t; -*-



(defun slang/conda-env-activate ()
  "Wrapper for pyvenv-activate that also restarts the lsp-sessions."
  (interactive)
  (call-interactively 'conda-env-activate)
  (call-interactively 'lsp-restart-workspace))

(defun slang/pyvenv-activate ()
  "Wrapper for pyvenv-activate that also restarts the lsp-sessions."
  (interactive)
  (call-interactively 'pyvenv-activate)
  (call-interactively 'lsp-workspace-shutdown)
  (call-interactively 'lsp))


(defun slang/pdb-insert ()
  "Insert pdb statement."
  (interactive)
  (evil-open-above 1)
  (insert "__import__(\"pdb\").set_trace()")
  ;; (insert "breakpoint()")
  (evil-normal-state)
  (evil-next-line))
