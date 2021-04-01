;;; ../dotfiles/configs/emacs/.doom.d/+modules/lang/latex/keybindings.el -*- lexical-binding: t; -*-

(map! :map TeX-mode-map
      :localleader

      :desc "View" "v"     #'TeX-view
      :desc "Table of Contents" "t"     #'reftex-toc
      :desc "Format Section" ","     #'LaTeX-fill-section

      (:prefix ("c" . "compile")
      :desc "Project" "p"     #'slang/save-tex-file-and-compile
      :desc "Buffer" "b"     #'slang/tex-compile-buffer
      :desc "Region" "r"     #'slang/tex-compile-region
      :desc "Section" "s"     #'slang/tex-compile-section
      :desc "Environment" "e"     #'slang/tex-compile-environment
      )


      (:prefix ("f" . "format")
       :desc "Environment" "e"  #'LaTeX-fill-environment
       :desc "Paragraph" "p"  #'LaTeX-fill-paragraph
       :desc "Region" "r"  #'LaTeX-fill-region
       :desc "Section" "s"  #'LaTeX-fill-section)
      )
