;;; ../dotfiles/configs/emacs/.doom.d/lang/+latex.el -*- lexical-binding: t; -*-
(after! tex
  (load! "+functions")
  (load! "+keybindings")

  ;; Set latex viewer
  ;; (setq +latex-viewers '(evince))
  (setq +latex-viewers '(pdf-tools))

  ;; Let evince not steal focus
  (setq TeX-view-evince-keep-focus t)

  ;; Make latex sections have a larger font
  (setq font-latex-fontify-sectioning 1.3)

  ;; Add auto-fillmode (auto line brake after 80 chars)
  (add-hook 'TeX-mode-hook #'auto-fill-mode)

  ;; Also fontify commonly custom commands defined by \newcomand
  ;; (push '("\citeauthorandref" "[{") font-latex-match-reference-keywords)
  ;; (setq font-latex-match-reference-keywords
  ;;       '(("\citeauthorandref" "[{")))
)
