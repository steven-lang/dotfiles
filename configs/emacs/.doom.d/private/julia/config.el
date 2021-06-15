;;; ../dotfiles/configs/emacs/.doom.d/lang/+julia.el -*- lexical-binding: t; -*-
(after! julia
  (load! "+functions")
  (load! "+keybindings")


  ;; Set julia lsp environment
  (use-package! lsp-julia
    :config
    (setq lsp-julia-default-environment "~/.julia/environments/v1.6")
    (setq lsp-folding-range-limit 100)
        (setq lsp-enable-folding t))

  (add-hook 'julia-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
  )
