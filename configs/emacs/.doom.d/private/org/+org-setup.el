;; org-gcal settings
(load! "+org-gcal-credentials")
(load! "+agenda")

;; Hide emphasis markers like /foo/ and *bar*
(setq org-hide-emphasis-markers nil)
;; Show emphasis markers at point
(use-package! org-appear
  :after org
  :config
  (add-hook 'org-mode-hook 'org-appear-mode)
  (setq org-appear-autolinks t))


;; (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(add-hook 'org-mode-hook 'org-superstar-mode)
(remove-hook 'org-mode-hook 'writegood-mode)
(remove-hook 'org-mode-hook 'org-bullets-mode)


;; Bigger latex fragments
(plist-put org-format-latex-options :scale 2)


;; Org-Mode todo keywords
(setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "WAITING(w)" "|" "DONE(d)" "CANCELED(c)")))

(defun slang/notify-send (title message)
  "Send a notification."
  (call-process "notify-send"
                nil 0 nil
                title
                message
                "--expire-time" "300000" ; 5 minutes
                "--app-name" "Emacs"))


;; Custom faces
(custom-set-faces
 ;; '(org-agenda-structure ((t (:foreground "#ECEFF4" :box (:line-width 1 :style released-button) :weight ultra-bold :height 1.5))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.15))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.10))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.05))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
 ;; '(org-super-agenda-header ((t (:inherit org-agenda-structure :box nil :height 0.8))))
 '(helm-buffer-modified ((t (:inherit font-lock-comment-face :foreground "IndianRed2"))))
 )

;; Org-ref setup
(use-package! org-ref
  :after org
  :config
  (setq reftex-default-bibliography '("~/org/bib/refereces.bib")
        org-ref-bibliography-notes "~/org/bib/notes.org"
        org-ref-default-bibliography '("~/org/bib/references.bib")
        bibtex-completion-bibliography "~/org/bib/references.bib"
        bibtex-completion-library-path "~/org/bib/bibtex-pdfs"
        bibtex-completion-notes-path "~/org/bib/helm-bibtex-notes"))



;; ox-latex
(use-package! ox-latex
  :after org
  :config
  (add-to-list 'org-latex-classes
               '("tudabeamer"
                 "\\documentclass\[presentation\]\{tudabeamer\}"
                 ("\\section\{%s\}" . "\\section*\{%s\}")
                 ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
                 ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))
  (add-to-list 'org-latex-packages-alist '("" "listings"))
  (add-to-list 'org-latex-packages-alist '("" "color"))
  (add-to-list 'org-latex-packages-alist '("" "tikz"))
  (setq org-latex-pdf-process '("latexmk -f -pdf %f -output-directory=%o"))
  (setq org-latex-listings t))

;; ox-beamer translates *bold* to \alert{}, the following function reverts this
(defun my-beamer-bold (contents backend info)
    (when (eq backend 'beamer)
    (replace-regexp-in-string "\\`\\\\[A-Za-z0-9]+" "\\\\textbf" contents)))

(add-to-list 'org-export-filter-bold-functions 'my-beamer-bold)

;; Make exports async by default
(setq org-export-in-background t)


;; Make TAB cycle all subtrees
(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))

;; Set PDF viewer
(add-to-list 'org-file-apps '("\\.pdf" . "emacsclient -c -a '' %s"))

;; Toggle latex fragments automatically with pointer
;; (add-hook 'org-mode-hook 'org-fragtog-mode)

;;;;;;;;;;;;;;;;;;; Org-Roam START
(use-package! deft
  :after org
  :defer
  :config
  ;; (setq deft-recursive t)
  ;; (setq deft-use-filter-string-for-filename t)
  ;; (setq deft-default-extension "org")
  (setq deft-use-filename-as-title t))

(use-package! org-roam
  :after org
  :defer
  :config
  (setq org-roam-directory deft-directory))
;;Org-Roam END


;; Org-superstar

;; Enable mixed-pixed font for org-mode
;; (add-hook 'org-mode-hook #'mixed-pitch-mode)

;; Hide emphasis markers
;; (setq org-hide-emphasis-markers t)

(setq org-startup-folded nil)

;; (use-package! org-noter
;;   :commands (org-noter)
;;   :config
;;   (require 'org-noter-pdftools)
;;   (after! pdf-tools
;;     (setq pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note))
;;   (setq org-noter-notes-mode-map (make-sparse-keymap)))

;; (use-package! org-pdftools
;;   :init (setq org-pdftools-search-string-separator "??")
;;   :config
;;   (after! org
;;     (org-link-set-parameters "pdftools"
;;                              :follow #'org-pdftools-open
;;                              :complete #'org-pdftools-complete-link
;;                              :store #'org-pdftools-store-link
;;                              :export #'org-pdftools-export)
;;     (add-hook 'org-store-link-functions 'org-pdftools-store-link)))

;; Set superstart bullet item list
(setq org-superstar-item-bullet-alist '((45 . 8226)
                                        (43 . 10148)
                                        (42 . 8211)))

;; Enable latex previews at startup
;; (setq org-startup-with-latex-preview nil)

;; (add-hook 'org-mode-hook 'org-fragtog-mode)

;; Set org agenda face
(custom-set-faces!
  '(org-agenda-structure :height 1.5 :weight ultra-bold ;;:foreground "#bbc2cf"
                         :box
                         (:line-width 2 :color "grey75" :style released-button)
                         )
  '(org-super-agenda-header :height 0.8 :box nil :inherit (org-agenda-structure)))


;; Latex tikz
(eval-after-load "preview"
  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t))
(setq org-preview-latex-default-process 'imagemagick)


(setq slang/doom-one-colors-alist '(('red . "#ff6c6b")
                                    ('green . "#98be65")
                                    ('yellow . "#ECBE7B")
                                    ('blue . "#51afef")
                                    ('magenta . "#c678dd")
                                    ('cyan . "#46D9FF")))

(defun slang/set-org-todo-keyword-faces-from-theme-color-alist (theme-colors)
  "Argument theme-colors is an alist from modus themes."
  (setq org-todo-keyword-faces
        `(("TODO"      :foreground ,(cdr (assoc 'green theme-colors)) :weight bold)
          ("STARTED"   :foreground ,(cdr (assoc 'yellow theme-colors)) :weight bold)
          ("NEXT"      :foreground ,(cdr (assoc 'cyan theme-colors)) :weight bold)
          ("WAITING"   :foreground ,(cdr (assoc 'magenta theme-colors)) :weight bold)
          ("DONE"      :foreground ,(cdr (assoc 'blue theme-colors)) :weight bold)
          ("CANCELED"  :foreground ,(cdr (assoc 'red theme-colors)) :weight bold))))

(defun slang/set-org-todo-keyword-faces ()
  "Set org todo keyword face using circadian.el hook on theme loading."
  (if (eq doom-theme slang/theme-dark)
      (slang/set-org-todo-keyword-faces-from-theme-color-alist slang/doom-one-colors-alist)
    (slang/set-org-todo-keyword-faces-from-theme-color-alist modus-themes-operandi-colors)))

(slang/set-org-todo-keyword-faces)

;; Disable prettification if symbol is at point and right of point
(setq prettify-symbols-unprettify-at-point 'right-edge)

;; List of symbols to be prettified
(setq-default prettify-symbols-alist
              '(("#+BEGIN_SRC" . ">>")
                ("#+END_SRC" . ">>")
                ("#+begin_src" . ">>")
                ("#+end_src" . ">>")
                (">=" . "≥")
                ("=>" . "⇨")
                ("[ ]"  "☐")
                ("[X]" . "☑" )
                ("[-]" . "❍" )
                ("[ ]" . "☐")
                ("[X]" . "☑")))
(add-hook 'org-mode-hook 'prettify-symbols-mode)

;; (add-to-list 'org-emphasis-alist '("!" (:foreground "red")))


(after! org-journal
  (setq org-journal-dir "~/org/journal/")
  (setq org-journal-file-type 'monthly))
