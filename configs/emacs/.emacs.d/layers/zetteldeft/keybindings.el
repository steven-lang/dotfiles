(with-eval-after-load 'deft
    (define-key deft-mode-map
        (kbd "<tab>") 'efls/deft-open-preview)
    (define-key deft-mode-map
        (kbd "<s-return>") 'efls/deft-open-other)
    (define-key deft-mode-map
        (kbd "s-j") 'evil-next-line)
    (define-key deft-mode-map (kbd "s-k") 'evil-previous-line))
