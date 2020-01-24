;; Org mode
(use-package org
  :after org-bullets
  :hook ((org-mode . visual-line-mode)
         (org-mode . org-indent-mode)
         (org-mode . org-bullets-mode)))

;; Org bullts
;; (use-package org-bullets :hook (org-mode . org-bullets-mode))
(use-package org-bullets :config
    (add-hook 'org-mode-hook (lambda () (setq org-bullets-mode t))))
(use-package org-ql)
(use-package org-super-agenda)
(use-package org-gcal)
(use-package org-ref)
