;;; ../dotfiles/configs/emacs/.doom.d/lang/+org.el -*- lexical-binding: t; -*-

;; Set directioreis of org, org-roam and deft
(setq deft-directory "~/org/notes/")
(setq org-directory "~/org/")
(setq org-roam-directory "~/org/notes")


;; Org setup
(after! org
  (load! "+functions")
  (load! "+keybindings")
  (load! "+org-setup"))
