;; -*- no-byte-compile: t; -*-

;; Formatting, TODO: does lsp provide this as well?
(package! blacken)

;; Docstring generation
(package! py-pyment :recipe (:host github :repo "humitos/py-cmd-buffer.el"))
(package! buftra :recipe (:host github :repo "humitos/buftra.el"))  ;; py-pyment dependency!
