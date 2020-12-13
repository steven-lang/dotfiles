;;; ../dotfiles/configs/emacs/.doom.d/+modules/lang/latex/functions.el -*- lexical-binding: t; -*-

(defun slang/save-tex-file-and-build ()
  "Save the current file and run the TeX-command-run-all procedure."
  (interactive)
  (save-buffer)
  (TeX-command-run-all nil))
