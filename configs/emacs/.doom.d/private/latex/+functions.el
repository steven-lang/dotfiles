;;; ../dotfiles/configs/emacs/.doom.d/+modules/lang/latex/functions.el -*- lexical-binding: t; -*-

(defun slang/save-tex-file-and-compile (&optional override-confirm)
  "Save the current file and run the TeX-command-run-all procedure."
  (interactive "P")
  (save-buffer)
  (TeX-command-run-all nil))


(defun slang/tex-compile-buffer (&optional override-confirm)
  "Compile the current buffer."
  (interactive "P")
  ;; Set region to buffer min max
  (let ((TeX-command-region-begin (point-min))
        (TeX-command-region-end (point-max)))

  ;; Update region file
  (TeX-region-update)

  ;; Run latex on region file
  (TeX-command "LaTeX" 'TeX-region-file override-confirm)))


(defun slang/tex-compile-region (&optional override-confirm)
  "Compile the current region."
  (interactive "P")
        ;; Update region file with current marks (selection)
        (TeX-region-update)

        ;; Run latex on region file
        (TeX-command "LaTeX" 'TeX-region-file override-confirm)
)


(defun slang/tex-compile-section (&optional override-confirm)
  "Compile the current region."
  (interactive "P")
  ;; Save where point is now and jump back afterwards
  (save-excursion
        ;; Set marks to the current section
        (LaTeX-mark-section)

        ;; Update region file with current marks (section)
        (TeX-region-update)

        ;; Run latex on region file
        (TeX-command "LaTeX" 'TeX-region-file override-confirm)))


(defun slang/tex-compile-environment (&optional override-confirm)
  "Compile the current region."
  (interactive "P")
  ;; Save where point is now and jump back afterwards
  (save-excursion
        ;; Set marks to the current section
        (LaTeX-mark-environment)
        ;; Update region file with current marks (section)
        (TeX-region-update)

        ;; Run latex on region file
        (TeX-command "LaTeX" 'TeX-region-file override-confirm)))
