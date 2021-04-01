;;; ../dotfiles/configs/emacs/.doom.d/tools/+lsp.el -*- lexical-binding: t; -*-
(after! lsp-mode
  (load! "+functions")
  (load! "+keybindings")

  ;; Ignore __pycache__ directories
  (push "[/\\\\]_pycache_\\'" lsp-file-watch-ignored-directories)

  ;; Enable lsp-header-breadcrumbs (similar to which-func mode but lsp wide)
  (setq lsp-headerline-breadcrumb-enable t)

  ;; Set file-watcher higher
  (setq lsp-file-watch-threshold 2000)
  )
