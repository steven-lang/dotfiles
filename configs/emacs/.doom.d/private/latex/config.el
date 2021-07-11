;;; ../dotfiles/configs/emacs/.doom.d/lang/+latex.el -*- lexical-binding: t; -*-
(after! tex
  (load! "+functions")
  (load! "+keybindings")

  ;; Set latex viewer
  ;; (setq +latex-viewers '(zathura))
  (setq +latex-viewers '(pdf-tools))  ;; Results in wrong-type-argument bufferp, nil error for now
  ;; (setq +latex-viewers '(evince))

 ;; to use pdfview with auctex
 ;; (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
 ;;    TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
 ;;    ;; TeX-source-correlate-start-server t
 ;;    ) ;; not sure if last line is neccessary

  ;; Let evince not steal focus
  (setq TeX-view-evince-keep-focus t)

  ;; Make latex sections have a larger font
  (setq font-latex-fontify-sectioning 1.3)

  ;; Add auto-fillmode (auto line brake after 80 chars)
  (add-hook 'TeX-mode-hook #'auto-fill-mode)

  ;; Also fontify commonly custom commands defined by \newcomand
  (add-hook 'TeX-mode-hook #'(lambda () (push '("citeauthorandref" "[{") font-latex-match-reference-keywords)))

  (setq-default TeX-master "main")
  )
