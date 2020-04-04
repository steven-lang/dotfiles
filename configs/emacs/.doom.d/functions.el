(defun slang/switch-to-scratch ()
  "Switch to scratch buffer."
  (interactive)
  (switch-to-buffer "*scratch*"))


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
(add-hook 'compilation-finish-functions 'slang/bury-compile-buffer-if-successful)


;; https://gist.github.com/mads-hartmann/3402786
(defun toggle-maximize-buffer () "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_) 
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))


(defun slang/pyvenv-activate ()
  "Wrapper for pyvenv-activate that also restarts the lsp-sessions."
  (interactive)
  (call-interactively 'pyvenv-activate)
  (call-interactively 'lsp-workspace-shutdown)
  (call-interactively 'lsp))


(defun slang/ipdb-insert ()
  "Insert ipdb statement."
  (interactive)
  (evil-open-above 1)
  (insert "__import__(\"ipdb\").set_trace(context=13)")
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

(after! org-roam
  (defun org-roam-tomorrow ()
    "Create the file for tomorrow."
    (interactive)
    (org-roam-new-file-named (format-time-string "%Y-%m-%d" (time-add 86400 (current-time)))))


  (defun org-roam-date ()
    "Insert a date at point using `org-read-date' with its optional argument
  of TO-TIME so that the user can customize the date format more easily.
  Source: https://emacs.stackexchange.com/a/42550."
    (interactive)
    (let ((time (org-read-date nil 'to-time nil "Date:  ")))
      (org-roam-new-file-named (format-time-string "%Y-%m-%d" time)))))

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
