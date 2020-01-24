;; Normal mode binding
(general-def emacs-lisp-mode-map
    :states '(normal)
    "K" 'elisp-slime-nav-describe-elisp-thing-at-point)

;; Major mode bindings
(general-def emacs-lisp-mode-map
    :states '(normal visual emacs)
    :prefix ","
    "e" 'eval-last-sexp)
