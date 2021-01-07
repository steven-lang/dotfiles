;;; ../dotfiles/configs/emacs/.doom.d/+modules/lang/latex/keybindings.el -*- lexical-binding: t; -*-

(map! :map TeX-mode-map
      "C-c C-c"         #'slang/save-tex-file-and-build)
      ;; "C-c C-m"         #'helm-insert-latex-math)

(map! :localleader
      :map TeX-mode-map

      "v"     #'TeX-view
      "b"     #'slang/save-tex-file-and-build
      "t"     #'reftex-toc
      "="     #'LaTeX-fill-section

      (:prefix ("f" . "format")
       "e"  #'LaTeX-fill-environment
       "p"  #'LaTeX-fill-paragraph
       "r"  #'LaTeX-fill-region
       "s"  #'LaTeX-fill-section))
