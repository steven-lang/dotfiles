;; Add electric-pair-mode in org-mode
(add-hook 'org-mode-hook 'electric-pair-mode)

;; Fix outline separator
(setq org-super-agenda-auto-group-outline-path-separator " | ")
(org-super-agenda--def-auto-group outline-path "their outline paths"
    :key-form (org-super-agenda--when-with-marker-buffer (org-super-agenda--get-marker item)
                (s-join org-super-agenda-auto-group-outline-path-separator (org-get-outline-path))))


;; Bigger latex fragments
(plist-put org-format-latex-options :scale 2)

;; Default org file when using capture (C-c c)
(setq org-default-notes-file "~/Dropbox/orgmode/gtd/inbox.org")

;; Org agenda files: look for all files in the following directory
(setq org-agenda-files
    (quote ("~/Dropbox/orgmode/gtd")))

;; Org-Capture Templates
(setq org-capture-templates
        '(;; Todo entries
        ("t"
            "Todo"
            entry
            (file+headline org-default-notes-file "Inbox")
            "** TODO %?\n:PROPERTIES:\n:CREATED:\t%u\n:END:\n"
            ;; :clock-in t
            ;; :clock-resume t
            :empty-lines 1)

        ("j"
         "Journal"
         entry
         (file+datetree "~/Dropbox/orgmode/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ))


;; Set the org refile targets to org agenda files
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                (org-agenda-files :maxlevel . 2))))

;; Set default column view headings: Task Total-Time Time-Stamp
;; (setq org-columns-default-format "%50ITEM(Task) %10CLOCKSUM %16TIMESTAMP_IA")

(defun jethro/switch-to-agenda ()
    (interactive)
    (org-agenda nil "a")
    (delete-other-windows))

(setq org-agenda-window-setup 'reorganize-frame)

;; Set f1 to open agenda
(bind-key "<f1>" 'jethro/switch-to-agenda)

;; Set org-done face
;; (org-done ((t (:strike-through t :weight bold))))

;; Set org-columns view default format (activate in agenda view with ", c")
(setq org-columns-default-format "%40ITEM(Task) %Effort(EE){:} %CLOCKSUM(Time Spent) %SCHEDULED(Scheduled) %DEADLINE(Deadline)")

;; Org-Mode todo keywords
(setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "WAITING(w)" "|" "DONE(d)" "CANCELED(c)")))

;; Set todo keyword colors
(setq org-todo-keyword-faces
        '(
        ("TODO"      :foreground "#99c794" :weight bold)
        ("STARTED"   :foreground "#fac863" :weight bold)
        ("NEXT"      :foreground "#5fb3b3" :weight bold)
        ("WAITING"   :foreground "#6699cc" :weight bold)
        ;; ("UNCERTAIN" :foreground "#c594c5" :weight bold)
        ("DONE"      :foreground "#4f5b66" :weight bold)
        ("CANCELED"  :foreground "#ec5f67" :weight bold)
        )
        )

;; Disable TODO and DONE highlighting in org mode
(add-hook 'org-mode-hook (lambda () (hl-todo-mode -1)))
(add-hook 'org-mode-hook (lambda () (org-indent-mode t)))



;; Save buffer on clocking in/out
(add-hook 'org-clock-in-hook #'save-buffer)
(add-hook 'org-clock-out-hook #'save-buffer)


;; org-pomodoro
;; (setq org-pomodoro-clock-break t)

;; org-pomodoro mode hooks
(add-hook 'org-pomodoro-finished-hook
            (lambda ()
            (notify-send "Pomodoro completed!" "Time for a break.")))

(add-hook 'org-pomodoro-break-finished-hook
            (lambda ()
            (notify-send "Pomodoro Short Break Finished" "Ready for Another?")))

(add-hook 'org-pomodoro-long-break-finished-hook
            (lambda ()
            (notify-send "Pomodoro Long Break Finished" "Ready for Another?")))

(add-hook 'org-pomodoro-killed-hook
            (lambda ()
            (notify-send "Pomodoro Killed" "One does not simply kill a pomodoro!")))


(setq org-tag-alist
        '(
        ("@work" . ?w)
        ("@studying" . ?s)
        ("@home" . ?h)
        ("@freetime" . ?f)
        )
        )
;; Disable super-agenda keymap (breaks evil up/down on headers)
(setq org-super-agenda-header-map (make-sparse-keymap))

;; Set org agenda todo view (open with <f1>)
(setq slang/org-agenda-directory "~/Dropbox/orgmode/gtd/")
(setq slang/org-agenda-todo-view
        `("a" "Full Agenda"
        ((agenda ""
                ((org-agenda-span '14)
                ;; (org-super-agenda-groups '((:auto-parent t)))
                (org-deadline-warning-days 365)))


        ;; To be refiled
        (todo "TODO"
                ((org-agenda-overriding-header "To Refile")
                (org-agenda-files '(,(concat slang/org-agenda-directory "inbox.org")))))

        ;; Next Actions Category
        (alltodo ""
                    ((org-agenda-overriding-header "Next Actions")
                    (org-super-agenda-groups '((:discard (:not (:todo "NEXT")))
                                                (:auto-outline-path t)))
                    (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))

        ;; Waiting for category
        (alltodo ""
                    ((org-agenda-overriding-header "Waiting For")
                    (org-super-agenda-groups '((:discard (:not (:todo "WAITING")))
                                                (:auto-outline-path t)))
                    (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))

        ;; All in progress
        (alltodo ""
                ((org-agenda-overriding-header "Projects")
                (org-super-agenda-groups '(
                                            (:discard (:tag "someday")) ;; Don't show todos tagged with "someday"
                                            (:discard (:habit t)) ;; Don't show habits
                                            (:discard (:todo "WAITING")) ;; Don't show WAITING
                                            (:discard (:todo "NEXT")) ;; Don't show NEXT
                                            (:auto-outline-path t)
                                            ))
                (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))


        (tags "someday" ;; Only show those tagged with someday
                ((org-agenda-overriding-header "Someday/Maybe")
                (org-super-agenda-groups '(
                                            (:discard (:todo "DONE"))
                                            (:discard (:todo "CANCELED"))
                                            (:auto-outline-path t)))
                (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))

        (alltodo ""
                    ((org-agenda-overriding-header "Reference Material")
                    (org-super-agenda-groups '((:auto-outline-path t)))
                    (org-agenda-files '(,(concat slang/org-agenda-directory "reference-material.org")))))
        )
        nil
        ("/tmp/org-agenda.html")))

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
(add-to-list 'org-agenda-custom-commands `,slang/org-agenda-lower-eq-10-mins-view)
(add-to-list 'org-agenda-custom-commands `,(slang/make-org-agenda-custom-view "@work" "cw" "At Work"))
(add-to-list 'org-agenda-custom-commands `,(slang/make-org-agenda-custom-view "@home" "ch" "At Home"))
(add-to-list 'org-agenda-custom-commands `,(slang/make-org-agenda-custom-view "@studying" "cs" "At Studying"))
(add-to-list 'org-agenda-custom-commands `,(slang/make-org-agenda-custom-view "@freetime" "cf" "At Free Time"))

(defvar slang/org-current-effort "1:00" "Current effort for agenda items.")

(defun slang/my-org-agenda-set-effort (effort)
    "Set the effort property for the current headline."
    (interactive
    (list (read-string (format "Effort [%s]: " slang/org-current-effort) nil nil slang/org-current-effort)))
    (setq slang/org-current-effort effort)
    (org-agenda-check-no-diary)
    (let* ((hdmarker (or (org-get-at-bol 'org-hd-marker)
                        (org-agenda-error)))
        (buffer (marker-buffer hdmarker))
        (pos (marker-position hdmarker))
        (inhibit-read-only t)
        newhead)
    (org-with-remote-undo buffer
                            (with-current-buffer buffer
                            (widen)
                            (goto-char pos)
                            (org-show-context 'agenda)
                            (funcall-interactively 'org-set-effort nil slang/org-current-effort)
                            (end-of-line 1)
                            (setq newhead (org-get-heading)))
                            (org-agenda-change-all-lines newhead hdmarker))))



;; Process a single inbox item:
;; 1) Set tags
;; 2) Set priority
;; 3) Estimate effort
;; 4) Refile
(defun slang/org-agenda-process-inbox-item ()
    "Process a single item in the org-agenda."
    (interactive)
    (org-with-wide-buffer
    (org-agenda-todo)
    (org-agenda-set-tags)
    (org-agenda-priority)
    (call-interactively 'slang/my-org-agenda-set-effort)
    (org-agenda-refile nil nil t)))

;; Export agenda to html file
;; TODO: Send via telegram or upload to server
(defun slang/org-agenda-export ()
    (interactive)
    (org-agenda-write "~/Dropbox/orgmode/gtd/export/agenda.html")
    )

;; Define custom agenda keybindings
(add-hook 'org-agenda-mode-hook (lambda ()
    (progn
    (org-super-agenda-mode t))))


;; org-gcal settings
(load-file (concat emacs-dir "layers/org/calendar-credentials.el"))


;; Custom faces
(custom-set-faces
    '(org-agenda-structure ((t (:foreground "#ECEFF4" :box (:line-width 1 :style released-button) :weight ultra-bold :height 1.5))))
    '(org-level-1 ((t (:inherit outline-1 :height 1.3))))
    '(org-level-2 ((t (:inherit outline-2 :height 1.25))))
    '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
    '(org-level-4 ((t (:inherit outline-4 :height 1.15))))
    '(org-level-5 ((t (:inherit outline-5 :height 1.1))))
    '(org-super-agenda-header ((t (:inherit org-agenda-structure :box nil :height 0.8))))
    '(helm-buffer-modified ((t (:inherit font-lock-comment-face :foreground "IndianRed2"))))
    )

(custom-set-variables
    '(org-agenda-prefix-format
    '((agenda . "  %t ")
        (todo . "  • ")
        (tags . "  • ")
        (search . "  • ")))
    '(org-modules
    '(ol-bbdb ol-bibtex ol-docview ol-eww ol-gnus ol-info ol-irc ol-mhe org-protocol ol-rmail ol-w3m org-habit org-ql))
    '(org-priority-faces '((66 . "#f99157") (67 . "#65737e")))
    ;; '(org-super-agenda-mode t)
    )

;; Org babel
(org-babel-do-load-languages
    'org-babel-load-languages
    '((dot . t)))
(add-to-list 'org-src-lang-modes
                '("dot" . graphviz-dot-mode))


;; Org-ref setup
(require 'org-ref)
(setq org-ref-default-bibliography "~/Dropbox/orgmode/bibliography/references.bib"
        org-ref-pdf-directory "~/pdf/"
        bibtex-completion-bibliography "~/Dropbox/orgmode/bibliography/references.bib"
        bibtex-completion-library-path "~/Dropbox/orgmode/bibliography/bibtex-pdfs"
        bibtex-completion-notes-path "~/Dropbox/orgmode/bibliography/helm-bibtex-notes")

;; org-clock output for polybar
(defun slang/org-clock-output-polybar ()
    (let ((inhibit-message t) ;; Suppress minibuffer output
        (descr (if (org-no-properties org-clock-current-task)  ;; Check if there is a current task
                    (org-clock-get-clock-string)  ;; Obtain clock-string (has minutes and task name)
                    "No active task")))  ;; Reminder that there is no active task
    (write-region descr nil "~/tmp/org-clock-current-task")))  ;; Write to tmp file which is read by polybar
    

;; ox-latex
(require 'ox-latex)
(add-to-list 'org-latex-classes
                '("tudabeamer"
                "\\documentclass\[presentation\]\{tudabeamer\}"
                ("\\section\{%s\}" . "\\section*\{%s\}")
                ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
                ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))
(add-to-list 'org-latex-packages-alist '("" "listings"))
(add-to-list 'org-latex-packages-alist '("" "color"))
(setq org-latex-listings t)

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

(advice-add 'org-deadline       :after (η #'slang/org-save-all-org-buffers-silent))
(advice-add 'org-schedule       :after (η #'slang/org-save-all-org-buffers-silent))
(advice-add 'org-store-log-note :after (η #'slang/org-save-all-org-buffers-silent))
(advice-add 'org-todo           :after (η #'slang/org-save-all-org-buffers-silent))
