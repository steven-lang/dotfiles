;;; ../dotfiles/configs/emacs/.doom.d/+modules/lang/org/keybindings.el -*- lexical-binding: t; -*-

;; Org capture
;; (map! :after org
;;       :map org-mode-map
;;       :localleader
;;       "" nil)

(map! :after org
      :map org-mode-map
      :desc "Export Repeat" "<f5>" #'slang/org-export-dispatch-repeat-last-action)

;; (map! :after org
;;       :map org-mode-map
;;       :localleader

;;       "'" #'org-edit-special
;;       "e" #'org-export-dispatch
;;       "a" #'org-agenda
;;       "p" #'org-priority

;;       ;; More cycling options (timestamps, headlines, items, properties)
;;       "L" #'org-shiftright
;;       "H" #'org-shiftleft
;;       "J" #'org-shiftdown
;;       "K" #'org-shiftup

;;       ;; ;; Enable latex preview
;;       ;; "lp" #'org-latex-preview

;;       "*" #'org-ctrl-c-star
;;       "-" #'org-ctrl-c-minus
;;       "#" #'org-update-statistics-cookies
;;       "RET"   #'org-ctrl-c-ret
;;       "M-RET" #'org-meta-return

;;       ;; attachments
;;       "A" #'org-attach

;;       ;; Change between TODO sets
;;       "C-S-l" #'org-shiftcontrolright
;;       "C-S-h" #'org-shiftcontrolleft
;;       "C-S-j" #'org-shiftcontroldown
;;       "C-S-k" #'org-shiftcontrolup

;;       ;; Clock
;;       (:prefix ("C" . "Clock")
;;        "c" #'org-clock-cancel
;;        "d" #'org-clock-display
;;        "e" #'org-evaluate-time-range
;;        "g" #'org-clock-goto
;;        "i" #'org-clock-in
;;        "I" #'org-clock-in-last
;;        "o" #'org-clock-out
;;        "R" #'org-clock-report
;;        "r" #'org-resolve-clocks)

;;       (:prefix ("d" . "Deadline")
;;        "d" #'org-deadline
;;        "s" #'org-schedule
;;        "t" #'org-time-stamp
;;        "T" #'org-time-stamp-inactive)


;;       (:prefix ("f" . "Feed")
;;        "i" #'org-feed-goto-inbox
;;        "u" #'org-feed-update-all)

;;       (:prefix ("T" . "Toggle")
;;        "c" #'org-toggle-checkbox
;;        "e" #'org-toggle-pretty-entities
;;        "i" #'org-toggle-inline-images
;;        "l" #'org-toggle-link-display
;;        "t" #'org-show-todo-tree
;;        "T" #'org-todo
;;        "V" #'space-doc-mode
;;        "x" #'org-toggle-latex-fragment)

;;       (:prefix ("s" . "Subtree")
;;        "sa" #'org-toggle-archive-tag
;;        "A" #'org-archive-subtree
;;        "b" #'org-tree-to-indirect-buffer
;;        "d" #'org-cut-subtree
;;        "h" #'org-promote-subtree
;;        "j" #'org-move-subtree-down
;;        "k" #'org-move-subtree-up
;;        "l" #'org-demote-subtree
;;        "n" #'org-narrow-to-subtree
;;        "N" #'widen
;;        "r" #'org-refile
;;        "s" #'org-sparse-tree
;;        "S" #'org-sort)

;;       ;; tables
;;       (:prefix ("t" . "Tables")
;;        "a" #'org-table-align
;;        "b" #'org-table-blank-field
;;        "c" #'org-table-convert
;;        "dc" #'org-table-delete-column
;;        "dr" #'org-table-kill-row
;;        "e" #'org-table-eval-formula
;;        "E" #'org-table-export
;;        "f" #'org-table-field-info
;;        "h" #'org-table-previous-field
;;        "H" #'org-table-move-column-left
;;        "w" #'org-table-wrap-region

;;        ;; Table-insert
;;        (:prefix ("i" . "Insert")
;;         "c" #'org-table-insert-column
;;         "h" #'org-table-insert-hline
;;         "H" #'org-table-hline-and-move
;;         "r" #'org-table-insert-row
;;         "I" #'org-table-import
;;         "j" #'org-table-next-row
;;         "J" #'org-table-move-row-down
;;         "K" #'org-table-move-row-up
;;         "l" #'org-table-next-field
;;         "L" #'org-table-move-column-right
;;         "n" #'org-table-create
;;         "N" #'org-table-create-with-table.el
;;         "r" #'org-table-recalculate
;;         "s" #'org-table-sort-lines)

;;        ;; Table-toggle
;;        (:prefix ("T" . "Toggle")
;;         "tf" #'org-table-toggle-formula-debugger
;;         "to" #'org-table-toggle-coordinate-overlays))

;;       ;; Source blocks / org-babel
;;       (:prefix ("b" . "SRC")
;;        "p"     #'org-babel-previous-src-block
;;        "n"     #'org-babel-next-src-block
;;        "e"     #'org-babel-execute-maybe
;;        "o"     #'org-babel-open-src-block-result
;;        "v"     #'org-babel-expand-src-block
;;        "u"     #'org-babel-goto-src-block-head
;;        "g"     #'org-babel-goto-named-src-block
;;        "r"     #'org-babel-goto-named-result
;;        "b"     #'org-babel-execute-buffer
;;        "s"     #'org-babel-execute-subtree
;;        "d"     #'org-babel-demarcate-block
;;        "t"     #'org-babel-tangle
;;        "f"     #'org-babel-tangle-file
;;        "c"     #'org-babel-check-src-block
;;        "j"     #'org-babel-insert-header-arg
;;        "l"     #'org-babel-load-in-session
;;        "i"     #'org-babel-lob-ingest
;;        "I"     #'org-babel-view-src-block-info
;;        "z"     #'org-babel-switch-to-session
;;        "Z"     #'org-babel-switch-to-session-with-code
;;        "a"     #'org-babel-sha1-hash
;;        "x"     #'org-babel-do-key-sequence-in-edit-buffer)

;;       (:prefix ("i" . "Insert")
;;        ;; insertion
;;        "b" #'org-insert-structure-template
;;        "d" #'org-insert-drawer
;;        "e" #'org-set-effort
;;        "f" #'org-footnote-new
;;        "h" #'org-insert-heading
;;        "H" #'org-insert-heading-after-current
;;        "i" #'org-insert-item
;;        "l" #'org-insert-link
;;        "n" #'org-add-note
;;        "p" #'org-set-property
;;        "s" #'org-insert-subheading
;;        "t" #'org-set-tags-command))

;; Org agenda mode
(map! :after org
      :localleader
      :map org-agenda-mode-map

      "e"     #'org-agenda-set-effort
      "q"     #'org-agenda-quit
      "p"     #'slang/org-agenda-process-inbox-item
      "t"    #'org-agenda-todo
      (:prefix ("c" . "Clock")
       "i"    #'org-agenda-clock-in
       "o"    #'org-agenda-clock-out)

      "s" nil
      (:prefix ("s" . "schedule")
       "s"  #'org-agenda-schedule
       :desc "today" "0"  #'slang/org-agenda-schedule-today
       :desc "tomorrow" "1"  #'slang/org-agenda-schedule-tomorrow))


(map! :after org
      :map org-agenda-mode-map
      :n "RET"   #'org-agenda-switch-to
      :n "q"     #'org-agenda-quit
      :n "t"    #'org-agenda-todo
      :n "p"    #'slang/org-agenda-process-inbox-item
      :n "I"    #'org-agenda-clock-in
      :n "O"    #'org-agenda-clock-out
      :n "P"    nil
      :n "P"    #'org-pomodoro
      :n "j"    nil
      :n "j"    #'org-agenda-next-item
      :n "k"    nil
      :n "k"    #'org-agenda-previous-item
      :n "r"    #'org-agenda-redo)

(map! :leader
      "C"  #'org-capture)
