;;; ../dotfiles/configs/emacs/.doom.d/lang/+elisp.el -*- lexical-binding: t; -*-
(after! emacs-lisp
  (load! "+functions")
  (load! "+keybindings")

  ;; Use aggressive indenting in emacs-lisp-mode
  (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode))
