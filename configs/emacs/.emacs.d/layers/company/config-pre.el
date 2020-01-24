;; Company completion framework
(use-package company
  :diminish company-mode
  :hook (prog-mode . company-mode)
  :config
  ;; Enable company auto completion everywhere
  (global-company-mode t)
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.1
        company-selection-wrap-around t
        company-tooltip-align-annotations t
        company-frontends '(company-pseudo-tooltip-frontend ; show tooltip even for single candidate
                            company-echo-metadata-frontend))
  (with-eval-after-load 'company
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "C-p") 'company-select-previous)
    (define-key company-active-map (kbd "RET") 'company-complete-selection)))

;; Nice company faces
(custom-set-faces
'(company-tooltip-common
    ((t (:inherit company-tooltip :weight bold :underline nil))))
'(company-tooltip-common-selection
    ((t (:inherit company-tooltip-selection :weight bold :underline nil))))
)
