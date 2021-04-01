;;; ../dotfiles/configs/emacs/.doom.d/+modules/tools/pdf/keybindings.el -*- lexical-binding: t; -*-

(map! :map pdf-view-mode-map
      "/"  nil
      "/"  #'pdf-occur)
