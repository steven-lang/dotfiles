;; Set normal state as default for org-agenda-mode
;; TODO: This needs to be evaluated last or something?
;; (add-hook 'org-agenda-mode-hook '(lambda () (evil-set-initial-state 'org-agenda-mode 'normal)))
(evil-set-initial-state 'org-agenda-mode 'normal)

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
                  (s-join org-super-agenda-auto-group-outline-path-separator (org-get-outline-path)))))


;; Bigger latex fragments
(plist-put org-format-latex-options :scale 2)

;; Default org file when using capture (C-c c)
(setq org-default-notes-file "~/Dropbox/orgmode/gtd/inbox.org")

;; Org agenda files: look for all files in the following directory
(setq org-agenda-files (quote ("~/Dropbox/orgmode/gtd")))

;; Org-Capture Templates
(setq org-capture-templates
      '(;; Todo entries
        ("t"
         "Todo"
         entry
         (file+headline org-default-notes-file "Inbox")
         "** TODO %?\n:PROPERTIES:\n:CREATED:\t%u\n:END:\n"
         :empty-lines 1)
        ("e" "email" entry (file+headline org-default-notes-file "Inbox")
         "* TODO Reply: %a %?"))
      )


;; Set the org refile targets to org agenda files
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 2))))

;; Set default column view headings: Task Total-Time Time-Stamp
;; (setq org-columns-default-format "%50ITEM(Task) %10CLOCKSUM %16TIMESTAMP_IA")


(setq org-agenda-window-setup 'reorganize-frame)

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
        ("DONE"      :foreground "#4f5b66" :weight bold)
        ("CANCELED"  :foreground "#ec5f67" :weight bold)))


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

;; org-pomodoro mode hooks
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
(setq slang/org-agenda-directory "~/Dropbox/orgmode/gtd/")
(setq slang/org-agenda-todo-view
        `("a" "Full Agenda"
        ((agenda ""
                ((org-agenda-span '7)
                ;; (org-super-agenda-groups '((:auto-parent t)))
                (org-deadline-warning-days 365)))


        ;; To be refiled
        (org-ql-block 
         ;; Query
         '(todo)
          ((org-ql-block-header "To Refile")
            (org-super-agenda-groups '((:auto-outline-path t)))
            (org-agenda-files '(,(concat slang/org-agenda-directory "inbox.org")))))
        
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

        ;; TOMORROW
        (org-ql-block 
         ;; Query
         '(and (not (habit))
               (todo)
               (scheduled :to -1)) ;; Scheduled until yesterday but still todo -> missed
          ((org-ql-block-header "Missed Items")
            (org-super-agenda-groups '((:auto-outline-path t)))
            (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))

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

        ;; All in progress
        ;; (alltodo ""
        ;;         ((org-agenda-overriding-header "Projects")
        ;;         (org-super-agenda-groups '(
        ;;                                     (:discard (:tag "someday")) ;; Don't show todos tagged with "someday"
        ;;                                     (:discard (:habit t)) ;; Don't show habits
        ;;                                     (:discard (:todo "WAITING")) ;; Don't show WAITING
        ;;                                     (:discard (:todo "NEXT")) ;; Don't show NEXT
        ;;                                     (:auto-outline-path t)
        ;;                                     ))
        ;;         (org-agenda-files '(,(concat slang/org-agenda-directory "gtd.org")))))


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
      (org-agenda-refile)
      (org-save-all-org-buffers)))

;; Export agenda to html file
;; TODO: Send via telegram or upload to server
(defun slang/org-agenda-export ()
    (interactive)
    (org-agenda-write "~/Dropbox/orgmode/gtd/export/agenda.html"))

;; Enable super agenda mode
(add-hook 'org-agenda-mode-hook (lambda () (org-super-agenda-mode t)))


;; org-gcal settings
(load! "org-gcal-credentials.el")


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

(custom-set-variables
 '(org-agenda-prefix-format
   '((agenda . "  %t ")
     (todo . "  • ")
     (tags . "  • ")
     (search . "  • ")))
 '(org-modules
   '(ol-bbdb ol-bibtex ol-docview ol-eww ol-gnus ol-info ol-irc ol-mhe org-protocol ol-rmail ol-w3m org-habit org-ql))
 '(org-priority-faces '((66 . "#f99157") (67 . "#65737e")))
 )

;; Org-ref setup
(use-package! org-ref
  :after org
  :config
  (setq org-ref-default-bibliography "~/Dropbox/orgmode/bibliography/references.bib"
        org-ref-pdf-directory "~/pdf/"
        bibtex-completion-bibliography "~/Dropbox/orgmode/bibliography/references.bib"
        bibtex-completion-library-path "~/Dropbox/orgmode/bibliography/bibtex-pdfs"
        bibtex-completion-notes-path "~/Dropbox/orgmode/bibliography/helm-bibtex-notes"))

;; org-clock output for polybar
(defun slang/org-clock-output-polybar ()
    (let ((inhibit-message t) ;; Suppress minibuffer output
        (descr (if (org-no-properties org-clock-current-task)  ;; Check if there is a current task
                    (org-clock-get-clock-string)  ;; Obtain clock-string (has minutes and task name)
                    "No active task")))  ;; Reminder that there is no active task
    (write-region descr nil "~/tmp/org-clock-current-task")))  ;; Write to tmp file which is read by polybar
    

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
  (setq org-latex-pdf-process '("latexmk -g -pdf %f"))
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
(add-to-list 'org-file-apps '("\\.pdf" . "zathura %s"))

;; Toggle latex fragments automatically with pointer
;; (add-hook 'org-mode-hook 'org-fragtog-mode)

;;;;;;;;;;;;;;;;;;; Org-Roam START
(use-package! deft
      :after org
      :config
      (setq deft-recursive t)
      (setq deft-use-filter-string-for-filename t)
      (setq deft-default-extension "org")
      (setq deft-directory "~/Dropbox/orgmode/notes/")
      (setq deft-use-filename-as-title t))

(use-package! org-roam
      :after deft org
      :hook (org-mode . org-roam-mode)
      :config
      (setq org-roam-directory deft-directory))

(map! :leader
      (:prefix ("r" . "Roam")
        "d" #'deft
        "R" #'deft-refresh
        "r" #'org-roam
        "t" #'org-roam-today
        "f" #'org-roam-find-file
        "i" #'org-roam-insert
        "n" #'org-roam-new-file
        "g" #'org-roam-show-graph))
;;;;;;;;;;;;;;;;;;; Org-Roam END

;;;;;;;;;;;;;;;;;;; Zetteldeft START
;; (use-package! zetteldeft
;;   :defer
;;   :config
;;     ;; Deft config
;;     (setq deft-directory "~/Dropbox/orgmode/notes/"
;;         deft-recursive t)

;;     (defun slang/deft-other-window ()
;;       (interactive)
;;       (split-window-sensibly)
;;       (other-window 1)
;;       (deft)
;;       (evil-insert 1))

;;     (defun slang/zetteldeft-new-search-other-window ()
;;       (interactive)
;;       (split-window-sensibly)  ;; open in other window
;;       (other-window 1)  ;; Switch to next window
;;       (zetteldeft-deft-new-search)  ;; Open deft new search
;;       (goto-line 3)  ;; Set cursor to second line (first results)
;;       (evil-insert 1))  ;; Enter insert mode


;;     ;; Add title suffix
;;     (setq zetteldeft-title-suffix "
;;     #+OPTIONS: toc:nil num:0
;;     #+STARTUP: latexpreview showall

;;     *


;;     * References
;;     ")

;;     ;; Open preview
;;     (defun efls/deft-open-preview ()
;;       (interactive)
;;       (deft-open-file-other-window))
;;     ;; Open other window
;;     (defun efls/deft-open-other ()
;;       (interactive)
      ;; (deft-open-file-other-window t)))

;; (map! :leader
;;       (:prefix ("d" . "Zetteldeft")
;;         "d" #'slang/zetteldeft-new-search-other-window
;;         "R" #'deft-refresh
;;         "s" #'zetteldeft-search-at-point
;;         "c" #'zetteldeft-search-current-id
;;         "f" #'zetteldeft-follow-link
;;         "F" #'zetteldeft-avy-file-search-ace-window
;;         "l" #'zetteldeft-avy-link-search
;;         "t" #'zetteldeft-avy-tag-search
;;         "T" #'zetteldeft-tag-buffer
;;         "i" #'zetteldeft-find-file-id-insert
;;         "I" #'zetteldeft-find-file-full-title-insert
;;         "o" #'zetteldeft-find-file
;;         "n" #'zetteldeft-new-file
;;         "N" #'zetteldeft-new-file-and-link
;;         "r" #'zetteldeft-file-rename
;;         "x" #'zetteldeft-count-words
;;         "y" #'zetteldeft-copy-id-current-file
;;         "L" #'zetteldeft-insert-list-links))
;;;;;;;;;;;;;;;;;;; Zetteldeft END
