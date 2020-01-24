;; Snippets
(use-package yasnippet
  :diminish yas-minor-mode
  :preface (defvar tmp/company-point nil)
  :config
  (yas-global-mode +1)
  )

;; Include snippets
(use-package yasnippet-snippets)
