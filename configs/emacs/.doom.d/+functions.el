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


;; https://gist.github.com/mads-hartmann/3402786
(defun toggle-maximize-buffer () "Maximize buffer"
       (interactive)
       (if (= 1 (length (window-list)))
           (jump-to-register '_)
         (progn
           (window-configuration-to-register '_)
           (delete-other-windows))))


(defun slang/switch-other-buffer ()
  "Switch to other buffer."
  (interactive)
  (switch-to-buffer (other-buffer)))


(defun slang/reload-config ()
  "Reload config."
  (interactive)
  (load! "config"))

(defun slang/timestamp-today-string-plus-n-days (n)
  (format-time-string "%Y-%m-%d" (time-add (* 60 60 24 n) (current-time))))


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
