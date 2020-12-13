;;; ../dotfiles/configs/emacs/.doom.d/email/+mu4e.el -*- lexical-binding: t; -*-

;; Use offlineimap as mu4e backend
;; (add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
;; (setq +mu4e-backend 'offlineimap)
;; (setq +mu4e-mu4e-mail-path "~/.mail")
;; (setq mu4e-get-mail-command "offlineimap -o")
;; (set-email-account! "GMail steven.lang.mz"
;;                     '((mu4e-sent-folder       . "/[Gmail].Sent Mail")
;;                       (mu4e-drafts-folder     . "/[Gmail].Drafts")
;;                       (mu4e-trash-folder      . "/[Gmail].Trash")
;;                       (mu4e-update-interval   . 300)
;;                       (smtpmail-smtp-user     . "steven.lang.mz@gmail.com")
;;                       (smtpmail-default-smtp-server . "smtp.gmail.com")
;;                       (smtpmail-smtp-server . "smtp.gmail.com")
;;                       (smtpmail-smtp-service . 587)
;;                       (smtpmail-local-domain . "gmail.com")
;;                       ;; (smtpmail-auth-credentials . (expand-file-name "~/.authinfo.gpg"))
;;                       (user-mail-address      . "steven.lang.mz@gmail.com"))
;;                     t)
;; (setq mu4e-update-interval 300)
;; (setq message-send-mail-function 'smtpmail-send-it
;;       starttls-use-gnutls t
;;       smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials
;;       '(("smtp.gmail.com" 587 "steven.lang.mz@gmail.com" nil))
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587)

;; Add action to view in browser
;; (add-to-list 'mu4e-view-actions
;;              '("View in Browser" . mu4e-action-view-in-browser) t)

;; (use-package! mu4e-alert
;;   :after mu4e
;;   :init
;;   (setq mu4e-alert-interesting-mail-query "flag:unread maildir:/Gmail/INBOX")
;;   (mu4e-alert-set-default-style 'libnotify)
;;   (mu4e-alert-enable-notifications))
