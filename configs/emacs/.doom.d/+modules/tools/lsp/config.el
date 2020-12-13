;;; ../dotfiles/configs/emacs/.doom.d/tools/+lsp.el -*- lexical-binding: t; -*-


;; Enable lsp-header-breadcrumbs (similar to which-func mode but lsp wide)
(add-hook! 'lsp-mode-hook #'lsp-headerline-breadcrumb-mode)
