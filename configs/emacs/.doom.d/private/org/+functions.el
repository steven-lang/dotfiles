;;; ../dotfiles/configs/emacs/.doom.d/+modules/lang/org/functions.el -*- lexical-binding: t; -*-


;; org-clock output for polybar
(defun slang/org-clock-output-polybar ()
  (let ((inhibit-message t) ;; Suppress minibuffer output
        (descr (if (org-no-properties org-clock-current-task)  ;; Check if there is a current task
                   (concat (org-clock-get-clock-string) " [" (org-pomodoro-format-seconds) "]")
                 ;; (org-clock-get-clock-string)  ;; Obtain clock-string (has minutes and task name)
                 "No active task")))  ;; Reminder that there is no active task
    (write-region descr nil "~/tmp/org-clock-current-task")))  ;; Write to tmp file which is read by polybar

(defun slang/org-export-dispatch-repeat-last-action ()
  "Repeat the last org-export action."
  (interactive)
  (org-export-dispatch org-export-dispatch-last-action))

(defun slang/switch-to-agenda ()
  (interactive)
  (org-agenda nil "a")
  (delete-other-windows)
  )

(defun slang/org-recent-done-items ()
  "Show recently done items (last week)."
  (org-ql-search (org-agenda-files)
    '(and (ts :from -7 :to today)
          (done))
    :title "Recent Items"
    :sort '(date priority todo)
    :super-groups '((:auto-ts t))))


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



(defun slang/org-save-all-org-buffers-silent ()
  "Save all org buffers but suppresses the output message."
    (let ((inhibit-message t))
      (org-save-all-org-buffers)))

(defun slang/org-agenda-schedule-today ()
  "Schedule an agenda element for today."
  (interactive)
  (org-agenda-schedule "Hello World" "+0d"))

(defun slang/org-agenda-schedule-tomorrow ()
  "Schedule an agenda element for tomorrow."
  (interactive)
  (org-agenda-schedule "Hello World" "+1d"))
