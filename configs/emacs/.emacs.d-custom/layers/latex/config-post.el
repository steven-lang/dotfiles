(defvar latex-build-command (if (executable-find "latexmk") "LatexMk" "LaTeX"))

(defun latex/build ()
  (interactive)
  (progn
    (let ((TeX-save-query nil))
      (TeX-save-document (TeX-master-file)))
    (TeX-command latex-build-command (TeX-master-file) -1)))
