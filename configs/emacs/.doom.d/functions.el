(defun slang/save-tex-file-and-build ()
  "Save the current file and run the TeX-command-run-all procedure."
  (interactive)
  (save-buffer)
  (TeX-command-run-all nil))


(defun slang/switch-to-scratch ()
  "Switch to scratch buffer."
  (interactive)
  (switch-to-buffer "*scratch*"))


;; org-clock output for polybar
(defun slang/org-clock-output-polybar ()
  (let ((inhibit-message t) ;; Suppress minibuffer output
        (descr (if (org-no-properties org-clock-current-task)  ;; Check if there is a current task
                   (concat (org-clock-get-clock-string) " [" (org-pomodoro-format-seconds) "]")
                 ;; (org-clock-get-clock-string)  ;; Obtain clock-string (has minutes and task name)
                 "No active task")))  ;; Reminder that there is no active task
    (write-region descr nil "~/tmp/org-clock-current-task")))  ;; Write to tmp file which is read by polybar

;; Close compilation buffer on succeed
(defun slang/bury-compile-buffer-if-successful (buffer string)
  "Bury a compilation buffer if succeeded without warnings
https://stackoverflow.com/questions/11043004/emacs-compile-buffer-auto-close/11059012#11059012"
  (when (and
         (buffer-live-p buffer)
         (string-match "compilation" (buffer-name buffer))
         (string-match "finished" string)
         )
    (run-with-timer 1 nil
                    (lambda (buf)
                      (bury-buffer buf)
                      (delete-windows-on buf))
                    buffer)))


;; https://gist.github.com/mads-hartmann/3402786
(defun toggle-maximize-buffer () "Maximize buffer"
       (interactive)
       (if (= 1 (length (window-list)))
           (jump-to-register '_)
         (progn
           (window-configuration-to-register '_)
           (delete-other-windows))))

(defun slang/conda-env-activate ()
  "Wrapper for pyvenv-activate that also restarts the lsp-sessions."
  (interactive)
  (call-interactively 'conda-env-activate)
  (call-interactively 'lsp-restart-workspace))

(defun slang/pyvenv-activate ()
  "Wrapper for pyvenv-activate that also restarts the lsp-sessions."
  (interactive)
  (call-interactively 'pyvenv-activate)
  (call-interactively 'lsp-workspace-shutdown)
  (call-interactively 'lsp))


(defun slang/pdb-insert ()
  "Insert pdb statement."
  (interactive)
  (evil-open-above 1)
  (insert "__import__(\"pdb\").set_trace()")
  (evil-normal-state)
  (evil-next-line))


(defun slang/switch-other-buffer ()
  "Switch to other buffer."
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun slang/org-export-dispatch-repeat-last-action ()
  "Repeat the last org-export action."
  (interactive)
  (org-export-dispatch org-export-dispatch-last-action))

(defun slang/switch-to-agenda ()
    (interactive)
    (org-agenda nil "a")
    (delete-other-windows))

(defun slang/reload-config ()
  "Reload config."
  (interactive)
  (load! "config.el"))

(defun slang/timestamp-today-string-plus-n-days (n)
  (format-time-string "%Y-%m-%d" (time-add (* 60 60 24 n) (current-time))))

;; (after! org-roam
;;   (defun org-roam-tomorrow ()
;;     "Create the file for tomorrow."
;;     (interactive)
;;     (org-roam-new-file-named (format-time-string "%Y-%m-%d" (time-add 86400 (current-time)))))


  ;; (defun org-roam-date ()
  ;;   "Insert a date at point using `org-read-date' with its optional argument
  ;; of TO-TIME so that the user can customize the date format more easily.
  ;; Source: https://emacs.stackexchange.com/a/42550."
  ;;   (interactive)
  ;;   (let ((time (org-read-date nil 'to-time nil "Date:  ")))
  ;;     (org-roam-new-file-named (format-time-string "%Y-%m-%d" time)))))

(defun ap/load-doom-theme (theme)
  "Disable active themes and load a Doom theme."
  (interactive (list (intern (completing-read "Theme: "
                                              (->> (custom-available-themes)
                                                   (-map #'symbol-name)
                                                   (--select (string-prefix-p "doom-" it)))))))
  (ap/switch-theme theme))

(defun ap/switch-theme (theme)
  "Disable active themes and load THEME."
  (interactive (list (intern (completing-read "Theme: "
                                              (->> (custom-available-themes)
                                                   (-map #'symbol-name))))))
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme 'no-confirm))

(defun slang/notify-send (title message)
  "Call notify-send with the given title and message to send
   a notification to the desktop environment."
  (call-process "notify-send"
                nil 0 nil
                title
                message
                "--expire-time" "300000" ; 5 minutes
                "--app-name" "Emacs"
                ))

(defun slang/load-theme-light ()
  "Load the light theme saved in the slang/theme-light variable."
  (interactive)
  (load-theme slang/theme-light))

(defun slang/load-theme-dark ()
  "Load the light theme saved in the slang/theme-light variable."
  (interactive)
  (load-theme slang/theme-dark))
