;; org-gcal settings
(load! "+org-gcal-credentials")

;; Set normal state as default for org-agenda-mode
;; TODO: This needs to be evaluated last or something?
(add-hook 'org-agenda-mode-hook '(lambda () (evil-set-initial-state 'org-agenda-mode 'normal)))
;; (evil-set-initial-state 'org-agenda-mode 'normal)

;; (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(add-hook 'org-mode-hook 'org-superstar-mode)
(remove-hook 'org-mode-hook 'writegood-mode)
(remove-hook 'org-mode-hook 'org-bullets-mode)

;; Add electric-pair-mode in org-mode
;; (add-hook 'org-mode-hook 'electric-pair-mode)

;; Fix outline separator
(use-package! org-super-agenda
  :after org
  :defer
  :config
  (setq org-super-agenda-auto-group-outline-path-separator " | ")
  (org-super-agenda--def-auto-group outline-path "their outline paths"
    :key-form (org-super-agenda--when-with-marker-buffer (org-super-agenda--get-marker item)
                (concat (s-join org-super-agenda-auto-group-outline-path-separator (org-get-outline-path))
                        "\n"))))


;; Bigger latex fragments
(plist-put org-format-latex-options :scale 2)

;; Default org file when using capture (C-c c)
(setq org-default-notes-file "~/org/gtd/inbox.org")

;; Org agenda files: look for all files in the following directory
(setq org-agenda-files (quote ("~/org/gtd")))

;; Org-Capture Templates
(setq org-capture-templates
      '(;; Todo entries
        ("t"
         "Todo"
         entry
         (file+headline org-default-notes-file "Inbox")
         "** TODO %?\n:PROPERTIES:\n:CREATED:\t%u\n:END:\n"
         :empty-lines 1)
        ("m" "Master Thesis" entry (file+headline "~/org/gtd/gtd.org" "Master Thesis")
         "* TODO %?")
        ("e" "email" entry (file+headline org-default-notes-file "Inbox")
         "* TODO Reply: %a %?")))


;; Set the org refile targets to org agenda files
(setq org-refile-targets (quote (("~/org/gtd/gtd.org" :maxlevel . 9))))

;; Set default column view headings: Task Total-Time Time-Stamp
;; (setq org-columns-default-format "%50ITEM(Task) %10CLOCKSUM %16TIMESTAMP_IA")


(setq org-agenda-window-setup 'reorganize-frame)

;; Set org-columns view default format (activate in agenda view with ", c")
(setq org-columns-default-format "%40ITEM(Task) %Effort(EE){:} %CLOCKSUM(Time Spent) %SCHEDULED(Scheduled) %DEADLINE(Deadline)")

;; Org-Mode todo keywords
(setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "WAITING(w)" "|" "DONE(d)" "CANCELED(c)")))


;; Save buffer on clocking in/out
(add-hook 'org-clock-in-hook #'save-buffer)
(add-hook 'org-clock-out-hook #'save-buffer)


(defun slang/notify-send (title message)
  "Send a notification."
  (call-process "notify-send"
                nil 0 nil
                title
                message
                "--expire-time" "300000" ; 5 minutes
                "--app-name" "Emacs"))

(use-package! org-pomodoro
  :defer
  :config
  (setq org-pomodoro-play-sounds nil)
  ;; org-pomodoro mode hooks
  (setq org-pomodoro-clock-break t)  ;; Clock 30 minutes instead of 25
  (add-hook 'org-pomodoro-finished-hook
            (lambda ()
              (slang/notify-send "Pomodoro completed!" "Time for a break.")))

  (add-hook 'org-pomodoro-break-finished-hook
            (lambda ()
              (slang/notify-send "Pomodoro Short Break Finished" "Ready for Another?")))

  (add-hook 'org-pomodoro-long-break-finished-hook
            (lambda ()
              (slang/notify-send "Pomodoro Long Break Finished" "Ready for Another?")))

  (add-hook 'org-pomodoro-killed-hook
            (lambda ()
              (slang/notify-send "Pomodoro Killed" "One does not simply kill a pomodoro!")))
  )

;; Predefined tags
(setq org-tag-alist
      '(("@work" . ?w)
        ("@studying" . ?s)
        ("@home" . ?h)
        ("@freetime" . ?f)))

;; Disable super-agenda keymap (breaks evil up/down on headers)
(setq org-super-agenda-header-map (make-sparse-keymap))


(defun slang/org-recent-done-items ()
  "Show recently done items (last week)."
  (org-ql-search (org-agenda-files)
    '(and (ts :from -7 :to today)
          (done))
    :title "Recent Items"
    :sort '(date priority todo)
    :super-groups '((:auto-ts t))))


;; Set org agenda todo view (open with <f1>)
(setq slang/org-agenda-directory "~/org/gtd/")
(setq slang/org-agenda-todo-view
      `("a" "Full Agenda"
        ;; Agenda 10-day view
        ((agenda ""
                 ((org-agenda-span '10)
                  (org-agenda-start-day "-1d")
                  ;; (org-super-agenda-groups '((:auto-parent t)))
                  (org-deadline-warning-days 365)))


         ;; To be refiled
         (org-ql-block
          ;; Query
          '(todo)
          ((org-ql-block-header "Inbox")
           (org-super-agenda-groups '((:auto-outline-path t)))
           (org-agenda-files '(,(concat slang/org-agenda-directory "inbox.org")))))

         ;; Next Actions Category
         (org-ql-block
          ;; Query
          '(and (todo "NEXT")
                ;; (not (or (scheduled :on +1)
                ;;          (scheudeld :on today)))
                )
          ;; Variables
          ((org-ql-block-header "Next Actions")
           (org-super-agenda-groups '((:auto-outline-path t)))
           (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))


         ;; TODAY
         (org-ql-block
          ;; Query
          '(and (not (habit))
                (todo)
                (scheduled :on today))
          ((org-ql-block-header "Today")
           (org-super-agenda-groups '((:auto-outline-path t)))
           (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))

         ;; TOMORROW
         (org-ql-block
          ;; Query
          '(and (not (habit))
                (todo)
                (scheduled :on +1))
          ((org-ql-block-header "Tomorrow")
           (org-super-agenda-groups '((:auto-outline-path t)))
           (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))

         ;; Missed items
         (org-ql-block
          ;; Query
          '(and (not (habit))
                (todo)
                (scheduled :to -1)) ;; Scheduled until yesterday but still todo -> missed
          ((org-ql-block-header "Missed Items")
           (org-super-agenda-groups '((:auto-outline-path t)))
           (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))

         ;; Waiting Category
         (org-ql-block
          ;; Query
          '(and (todo "WAITING"))
          ;; Variables
          ((org-ql-block-header "Waiting For")
           (org-super-agenda-groups '((:auto-outline-path t)))
           (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))

         ;; Projects
         (org-ql-block
          ;; Query
          '(and (not (or (tags "someday")
                         (habit)
                         (todo "WAITING")
                         (todo "NEXT")))
                (todo))
          ;; Variables
          ((org-ql-block-header "Projects")
           (org-super-agenda-groups '((:auto-outline-path t)))
           (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))

         (org-ql-block
          ;; Query
          '(and (tags "someday")
                (todo))

          ;; Variables
          ((org-ql-block-header "Someday/Maybe")
           (org-super-agenda-groups '((:auto-outline-path t)))
           (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))

         ;; Reference Material
         (org-ql-block
          '(or (todo)
               (todo "WAITING"))

          ;; Variables
          ((org-ql-block-header "Reference Material")
           (org-super-agenda-groups '((:auto-outline-path t)))
           (org-agenda-files '(,(concat slang/org-agenda-directory "reference-material.org"))))))
        nil
        ("/tmp/org-agenda.html")))

(setq slang/org-agenda-next-view
      `("n" "Next Actions"
        (
         ;; Next Actions Category
         (org-ql-block
          ;; Query
          '(and (todo "NEXT")
                ;; (not (or (scheduled :on +1)
                ;;          (scheudeld :on today)))
                )
          ;; Variables
          ((org-ql-block-header "Next Actions")
           (org-super-agenda-groups '((:auto-outline-path t)))
           (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))
         )))

(setq slang/org-agenda-lower-eq-10-mins-view
      `("l" "Less than 10 minutes effort"
        (
         (agenda ""
                 ((org-agenda-span 'day)
                  (org-super-agenda-groups '(
                                             (:discard (:effort> "11"))
                                             (:auto-parent t)))
                  (org-deadline-warning-days 365)))
         (alltodo ""
                  ((org-agenda-overriding-header "Less than 10 minutes effort")
                   (org-super-agenda-groups '((:discard (:effort> "11"))
                                              (:discard (:habit t))
                                              (:auto-parent t)))
                   (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))
         )))


(defun slang/make-org-agenda-custom-view (tag key description)
    "Make a custom agenda view filtered by a specific context tag."
    `(,key ,description
        (

        ;; Next Actions Category
        (alltodo ""
                    ((org-agenda-overriding-header "Next Actions")
                    (org-super-agenda-groups '((:discard (:not (:todo "NEXT")))
                                                (:discard (:not (:tag ,tag)))
                                                (:auto-outline-path t)))
                    (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))

        ;; Waiting for category
        (alltodo ""
                    ((org-agenda-overriding-header "Waiting For")
                    (org-super-agenda-groups '((:discard (:not (:todo "WAITING")))
                                                (:discard (:not (:tag ,tag)))
                                                (:auto-outline-path t)))
                    (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))

        ;; Projects
        (alltodo ""
                    ((org-agenda-overriding-header ,description)
                    (org-super-agenda-groups '((:discard (:habit t))
                                                (:discard (:not (:tag ,tag)))
                                                (:discard (:todo "WAITING"))
                                                (:discard (:todo "NEXT"))
                                                (:discard (:tag "someday"))
                                                (:auto-outline-path t)))
                    (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))
        )))

;; (setq org-agenda-custom-commands
;;       '(("X" agenda "" nil ("agenda.html"))))
;; (setq org-agenda-custom-commands (list))
;; ;; Set to empty list is necessary or else org-agenda-custom-commands is not defined
(setq org-agenda-custom-commands (list))
(add-to-list 'org-agenda-custom-commands `,slang/org-agenda-todo-view)
(add-to-list 'org-agenda-custom-commands `,slang/org-agenda-next-view)
(add-to-list 'org-agenda-custom-commands `,slang/org-agenda-lower-eq-10-mins-view)
(add-to-list 'org-agenda-custom-commands `,(slang/make-org-agenda-custom-view "@work" "cw" "At Work"))
(add-to-list 'org-agenda-custom-commands `,(slang/make-org-agenda-custom-view "@home" "ch" "At Home"))
(add-to-list 'org-agenda-custom-commands `,(slang/make-org-agenda-custom-view "@studying" "cs" "At Studying"))
(add-to-list 'org-agenda-custom-commands `,(slang/make-org-agenda-custom-view "@freetime" "cf" "At Free Time"))
(add-to-list 'org-agenda-custom-commands `,(slang/make-org-agenda-custom-view "thesis" "t" "Master Thesis"))


;; Process a single inbox item:
;; 1) Set todo state
;; 2) Refile
(defun slang/org-agenda-process-inbox-item ()
  "Process a single item in the org-agenda."
  (interactive)
  ;; (org-with-wide-buffer
   (org-agenda-todo)
   (org-agenda-refile)
   (org-save-all-org-buffers)
   ;; )
)

;; Export agenda to html file
;; TODO: Send via telegram or upload to server
(defun slang/org-agenda-export ()
  (interactive)
  (org-agenda-write "~/org/gtd/export/agenda.html"))

;; Enable super agenda mode
(add-hook 'org-agenda-mode-hook (lambda () (org-super-agenda-mode t)))


;; Custom faces
(custom-set-faces
 ;; '(org-agenda-structure ((t (:foreground "#ECEFF4" :box (:line-width 1 :style released-button) :weight ultra-bold :height 1.5))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.3))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.25))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.15))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.1))))
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

;; https://emacs.stackexchange.com/questions/21754/how-to-automatically-save-all-org-files-after-marking-a-repeating-item-as-done-i
(defmacro η (fnc)
  "Return function that ignores its arguments and invokes FNC."
  `(lambda (&rest _rest)
     (funcall ,fnc)))

(defun slang/org-save-all-org-buffers-silent ()
  "Save all org buffers but suppresses the output message."
    (let ((inhibit-message t))
      (org-save-all-org-buffers)))

(advice-add 'org-agenda-deadline       :after (η #'slang/org-save-all-org-buffers-silent))
(advice-add 'org-agenda-schedule       :after (η #'slang/org-save-all-org-buffers-silent))
(advice-add 'org-store-log-note :after (η #'slang/org-save-all-org-buffers-silent))
(advice-add 'org-agenda-todo           :after (η #'slang/org-save-all-org-buffers-silent))




;; Make TAB cycle all subtrees
(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))

;; Set PDF viewer
(add-to-list 'org-file-apps '("\\.pdf" . "emacsclient -c -a '' %s"))

;; Toggle latex fragments automatically with pointer
(add-hook 'org-mode-hook 'org-fragtog-mode)

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


(defun slang/org-agenda-schedule-today ()
  "Schedule an agenda element for today."
  (interactive)
  (org-agenda-schedule "Hello World" "+0d"))

(defun slang/org-agenda-schedule-tomorrow ()
  "Schedule an agenda element for tomorrow."
  (interactive)
  (org-agenda-schedule "Hello World" "+1d"))

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


(setq slang/doom-one-colors-alist '(("red" . "#ff6c6b")
                                    ("green" . "#98be65")
                                    ("yellow" . "#ECBE7B")
                                    ("blue" . "#51afef")
                                    ("magenta" . "#c678dd")
                                    ("cyan" . "#46D9FF")))

(defun slang/set-org-todo-keyword-faces-from-theme-color-alist (theme-colors)
  "Argument theme-colors is an alist from modus themes."
  (setq org-todo-keyword-faces
        `(("TODO"      :foreground ,(cdr (assoc "green" theme-colors)) :weight bold)
          ("STARTED"   :foreground ,(cdr (assoc "yellow" theme-colors)) :weight bold)
          ("NEXT"      :foreground ,(cdr (assoc "cyan" theme-colors)) :weight bold)
          ("WAITING"   :foreground ,(cdr (assoc "magenta" theme-colors)) :weight bold)
          ("DONE"      :foreground ,(cdr (assoc "blue" theme-colors)) :weight bold)
          ("CANCELED"  :foreground ,(cdr (assoc "red" theme-colors)) :weight bold))))

(defun slang/set-org-todo-keyword-faces ()
  "Set org todo keyword face using circadian.el hook on theme loading."
  (if (eq doom-theme slang/theme-dark)
      (slang/set-org-todo-keyword-faces-from-theme-color-alist slang/doom-one-colors-alist)
    (slang/set-org-todo-keyword-faces-from-theme-color-alist modus-operandi-theme-default-colors-alist)))

(slang/set-org-todo-keyword-faces)

;; Register todo-keyword changes when theme changes with circadian.el
;; (use-package! circadian
;;   :config
;;   (add-hook 'circadian-after-load-theme-hook
;;             #'(lambda (theme)
;;                 (slang/set-org-todo-keyword-faces))))

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

(setq org-agenda-prefix-format '((agenda . "  %t ")
                                 (todo . "  • ")
                                 (tags . "  • ")
                                 (search . "  • ")))
