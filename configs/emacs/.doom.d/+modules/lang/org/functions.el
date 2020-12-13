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
  (delete-other-windows))
