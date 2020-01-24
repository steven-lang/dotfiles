(use-package zetteldeft
  :config
    ;; Deft config
    (setq deft-directory "~/Dropbox/orgmode/notes/"
        deft-recursive t)

    ;; (if other
    ;;     (if switch
    ;;         (switch-to-buffer-other-window buffer)
    ;;       (display-buffer buffer other))
    ;;   (switch-to-buffer buffer))
    (defun slang/deft-other-window ()
    (interactive)
    (split-window-sensibly)
    (other-window 1)
    (deft)
    (evil-insert 1))

    (defun slang/zetteldeft-new-search-other-window ()
    (interactive)
    (split-window-sensibly)  ;; open in other window
    (other-window 1)  ;; Switch to next window
    (zetteldeft-deft-new-search)  ;; Open deft new search
    (goto-line 3)  ;; Set cursor to second line (first results)
    (evil-insert 1))  ;; Enter insert mode


    ;; Add title suffix
    (setq zetteldeft-title-suffix "
    #+OPTIONS: toc:nil num:0
    #+STARTUP: latexpreview showall

    * 


    * References
    ")

    ;; Open preview
    (defun efls/deft-open-preview ()
    (interactive)
    (deft-open-file-other-window))
    ;; Open other window
    (defun efls/deft-open-other ()
    (interactive)
    (deft-open-file-other-window t))
  )
