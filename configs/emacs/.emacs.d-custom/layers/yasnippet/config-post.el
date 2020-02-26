(advice-add 'company-complete-common
            :before
            #'(lambda ()
                (setq tmp/company-point (point))))
(advice-add 'company-complete-common
            :after
            #'(lambda ()
                (when (equal tmp/company-point (point))
                (yas-expand))))
