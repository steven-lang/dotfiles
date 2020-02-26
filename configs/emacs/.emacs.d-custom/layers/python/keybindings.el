(defun slang/ipdb-insert ()
  (interactive)
  (evil-open-above 1)
  (insert "__import__(\"ipdb\").set_trace(context=13)")
  (evil-normal-state)
  (evil-next-line))
;; Make 'gd' call lsp-goto-definition
(general-def python-mode-map
  :states '(normal)
  "K"  'lsp-describe-thing-at-point
  "gr" 'lsp-ui-peek-find-references
  "gd" 'lsp-ui-peek-find-definitions
  "C-k"  'lsp-ui-doc-glance)

(general-def lsp-ui-peek-mode-map
  :states '(normal emacs)
  "j"  'evil-next-line
  "k"  'evil-previous-line)

(general-def python-mode-map
  :states '(normal emacs)
  :prefix ","
  "va" 'slang/pyvenv-activate
  "="  'python-black-buffer
  "s"  'helm-lsp-workspace-symbol

  "ib" 'slang/ipdb-insert
  )

;; Add dap keybindings to python mode
(add-hook 'python-mode-hook (lambda () (slang/add-dap-keybindings python-mode-map)))
