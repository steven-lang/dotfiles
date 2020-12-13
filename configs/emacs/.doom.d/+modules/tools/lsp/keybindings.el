;;; ../dotfiles/configs/emacs/.doom.d/+modules/tools/lsp/keybindings.el -*- lexical-binding: t; -*-


;; Make jk work in lsp ui peek mode
(map! :map lsp-ui-peek-mode-map
      "j"  #'lsp-ui-peek--select-next
      "k"  #'lsp-ui-peek--select-prev)
