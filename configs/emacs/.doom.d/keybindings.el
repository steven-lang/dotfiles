;; Switch to other buffer with "SPC TAB"
;; (map! :leader
;;       "TAB" nil

;;       :leader
;;       "TAB" #'slang/switch-other-buffer)

;; Window selection
(map!
 :leader

 "1"   #'winum-select-window-1
 "2"   #'winum-select-window-2
 "3"   #'winum-select-window-3
 "4"   #'winum-select-window-4
 "5"   #'winum-select-window-5
 "6"   #'winum-select-window-6
 "7"   #'winum-select-window-7
 "8"   #'winum-select-window-8
 "9"   #'winum-select-window-9
 )

(map! "M-h" #'evil-window-left
      "M-j" #'evil-window-down
      "M-k" #'evil-window-up
      "M-l" #'evil-window-right)

;; Use helm for M-x
(map! :leader
      ;; unmap first
      "SPC" nil 
      "`" nil

      :leader
      "SPC" #'counsel-M-x
      ;; "SPC" #'helm-M-x
      "."   #'+ivy/projectile-find-file


      "x"  nil
      (:prefix ("x" . "font")
       "-"  #'doom/decrease-font-size
       "+"  #'doom/increase-font-size))

;; Expand region with "SPC v"
(map! :leader
      "v"   #'er/expand-region)


;; Use F1 to open the agenda
(map! "<f1>"
      #'slang/switch-to-agenda)
;; Use F2 to open agenda selection
(map! "<f2>"
      #'org-agenda)


;; Utils
(map! :leader
      "u" nil ;; unbind first

      (:prefix ("u" . "utils")
       :desc "Search Google" "g" #'counsel-search ;; needs 'surfraw' binary
       ;; :desc "Search Google" "g" #'helm-google-suggest ;; needs 'surfraw' binary
       :desc "top" "t" #'helm-top
       :desc "kill-ring" "y" #'helm-show-kill-ring))

;; Buffers
(map! :leader (:prefix "b" "m" nil)
      :leader (:prefix "b" :desc "Messages" "m" #'(lambda () (interactive) (switch-to-buffer "*Messages*")))

      :leader (:prefix "b" "s" nil)
      :leader (:prefix "b" :desc "Messages" "s" #'(lambda () (interactive) (switch-to-buffer "*scratch*")))

      :leader (:prefix "b" "b" nil)
      ;; :leader (:prefix "b" :desc "Buffers" "b" #'helm-mini)
      :leader (:prefix "b" :desc "Buffers" "b" #'+ivy/switch-buffer))


;; Windows
(map! :leader
      (:prefix "w"
       :desc "Maximize" "m" #'toggle-maximize-buffer
       "w"  #'ace-window
       "/" nil
       :desc "Split right"  "/" #'(lambda () (interactive)(evil-window-vsplit) (other-window 1))
       :desc "Split below"  "-" #'(lambda () (interactive)(evil-window-split) (other-window 1))))



;; Make "C-h" go one dir back in helm
(map! :map helm-map
      "C-h" #'helm-find-files-up-one-level)


;; DAP mode
;; (map!
;;       :map python-mode-map
;;       :localleader
;;       "d" nil)
(map! :localleader
      :map python-mode-map
      "d"   #'py-pyment-region

      (:prefix ("D" . "DAP")
       ;; transient state
       "."  #'dap-hydra

       ;; repl
       "d'"  #'dap-ui-repl

       ;; abandon
       "a"  #'dap-disconnect
       "A"  #'dap-delete-all-sessions

       ;; stepping
       "c"  #'dap-continue
       "i"  #'dap-step-in
       "o"  #'dap-step-out
       "r"  #'dap-restart-frame
       ;; "s"  #'dap-next
       "v"  #'dap-ui-inspect-thing-at-point

       ;; breakpoints
       (:prefix ("b" . "Breakpoints")
        "b" #'dap-breakpoint-toggle
        "c" #'dap-breakpoint-condition
        "l" #'dap-breakpoint-log-message
        "h" #'dap-breakpoint-hit-condition
        "a" #'dap-breakpoint-add
        "d" #'dap-breakpoint-delete
        "D" #'dap-breakpoint-delete-all)

       (:prefix ("d" . "Debug")
        ;; debuging/running
        "d" #'dap-debug
        "e" #'dap-debug-edit-template
        "l" #'dap-debug-last
        "r" #'dap-debug-recent)

       (:prefix ("e" . "Eval")
        ;; eval
        "e" #'dap-eval
        "r" #'dap-eval-region
        "t" #'dap-eval-thing-at-point)

       (:prefix ("I" . "Inspect")
        ;; inspect
        "i" #'dap-ui-inspect
        "r" #'dap-ui-inspect-region
        "t" #'dap-ui-inspect-thing-at-point)


       ;; switching
       (:prefix ("s" . "Switch")
        "s" #'dap-switch-session
        "t" #'dap-switch-thread
        "f" #'dap-switch-frame)

       (:prefix ("w" . "Windows")
        ;; windows
        "o" #'dap-go-to-output-buffer
        "l" #'dap-ui-locals
        "s" #'dap-ui-sessions
        "b" #'dap-ui-breakpoints)))



;; Make #'gd' call lsp-goto-definition
(map! :map python-mode-map
      :n "K"  #'+lookup/documentation
      :n "gr" #'+lookup/references
      :n "gd" #'+lookup/definition
      :n "C-k"  #'lsp-ui-doc-glance)


;; (map! :map python-mode-map
;;       :localleader
;;       "i" nil)

(map! :map python-mode-map
      :localleader
      ;; "v" #'slang/pyvenv-activate
      "v" #'slang/conda-env-activate
      "="  #'blacken-buffer
      "s"  #'lsp-ivy-workspace-symbol
      ;; "s"  #'helm-lsp-workspace-symbol

      "b" #'slang/pdb-insert)

;; Make jk work in lsp ui peek mode
(map! :map lsp-ui-peek-mode-map
      "j"  #'lsp-ui-peek--select-next
      "k"  #'lsp-ui-peek--select-prev)


;; Use avy
(map! 
 :nv "s" nil
 (:prefix ("s" .  "jump")
  :nv "s"   #'+evil:swiper
  :nv "j"   #'evilem-motion-next-visual-line
  :nv "k"   #'evilem-motion-previous-visual-line
  :nv "w"   #'evilem-motion-forward-word-begin
  :nv "b"   #'evilem-motion-backward-word-begin
  :nv "c"   #'evilem-motion-find-char-backward
  :nv "C"   #'evilem-motion-find-char
  ))


;; Org capture
(map! :after org
      :map org-mode-map
      :localleader
      "" nil)

(map! :after org
      :map org-mode-map
      :desc "Export Repeat" "<f5>" #'slang/org-export-dispatch-repeat-last-action)

(map! :after org
      :map org-mode-map
      :localleader

      "'" #'org-edit-special
      "e" #'org-export-dispatch
      "a" #'org-agenda
      "p" #'org-priority

      ;; More cycling options (timestamps, headlines, items, properties)
      "L" #'org-shiftright
      "H" #'org-shiftleft
      "J" #'org-shiftdown
      "K" #'org-shiftup

      ;; ;; Enable latex preview
      ;; "lp" #'org-latex-preview

      "*" #'org-ctrl-c-star
      "-" #'org-ctrl-c-minus
      "#" #'org-update-statistics-cookies
      "RET"   #'org-ctrl-c-ret
      "M-RET" #'org-meta-return

      ;; attachments
      "A" #'org-attach

      ;; Change between TODO sets
      "C-S-l" #'org-shiftcontrolright
      "C-S-h" #'org-shiftcontrolleft
      "C-S-j" #'org-shiftcontroldown
      "C-S-k" #'org-shiftcontrolup

      ;; Clock
      (:prefix ("C" . "Clock")
        "c" #'org-clock-cancel
        "d" #'org-clock-display
        "e" #'org-evaluate-time-range
        "g" #'org-clock-goto
        "i" #'org-clock-in
        "I" #'org-clock-in-last
        "o" #'org-clock-out
        "R" #'org-clock-report
        "r" #'org-resolve-clocks)

      (:prefix ("d" . "Deadline")
        "d" #'org-deadline
        "s" #'org-schedule
        "t" #'org-time-stamp
        "T" #'org-time-stamp-inactive)


      (:prefix ("f" . "Feed")
        "i" #'org-feed-goto-inbox
        "u" #'org-feed-update-all)

      (:prefix ("T" . "Toggle")
        "c" #'org-toggle-checkbox
        "e" #'org-toggle-pretty-entities
        "i" #'org-toggle-inline-images
        "l" #'org-toggle-link-display
        "t" #'org-show-todo-tree
        "T" #'org-todo
        "V" #'space-doc-mode
        "x" #'org-toggle-latex-fragment)

      (:prefix ("s" . "Subtree")
        "sa" #'org-toggle-archive-tag
        "A" #'org-archive-subtree
        "b" #'org-tree-to-indirect-buffer
        "d" #'org-cut-subtree
        "h" #'org-promote-subtree
        "j" #'org-move-subtree-down
        "k" #'org-move-subtree-up
        "l" #'org-demote-subtree
        "n" #'org-narrow-to-subtree
        "N" #'widen
        "r" #'org-refile
        "s" #'org-sparse-tree
        "S" #'org-sort)

      ;; tables
      (:prefix ("t" . "Tables")
        "a" #'org-table-align
        "b" #'org-table-blank-field
        "c" #'org-table-convert
        "dc" #'org-table-delete-column
        "dr" #'org-table-kill-row
        "e" #'org-table-eval-formula
        "E" #'org-table-export
        "f" #'org-table-field-info
        "h" #'org-table-previous-field
        "H" #'org-table-move-column-left
        "w" #'org-table-wrap-region

        ;; Table-insert
        (:prefix ("i" . "Insert")
          "c" #'org-table-insert-column
          "h" #'org-table-insert-hline
          "H" #'org-table-hline-and-move
          "r" #'org-table-insert-row
          "I" #'org-table-import
          "j" #'org-table-next-row
          "J" #'org-table-move-row-down
          "K" #'org-table-move-row-up
          "l" #'org-table-next-field
          "L" #'org-table-move-column-right
          "n" #'org-table-create
          "N" #'org-table-create-with-table.el
          "r" #'org-table-recalculate
          "s" #'org-table-sort-lines)

        ;; Table-toggle
        (:prefix ("T" . "Toggle")
          "tf" #'org-table-toggle-formula-debugger
          "to" #'org-table-toggle-coordinate-overlays))

      ;; Source blocks / org-babel
      (:prefix ("b" . "SRC")
        "p"     #'org-babel-previous-src-block
        "n"     #'org-babel-next-src-block
        "e"     #'org-babel-execute-maybe
        "o"     #'org-babel-open-src-block-result
        "v"     #'org-babel-expand-src-block
        "u"     #'org-babel-goto-src-block-head
        "g"     #'org-babel-goto-named-src-block
        "r"     #'org-babel-goto-named-result
        "b"     #'org-babel-execute-buffer
        "s"     #'org-babel-execute-subtree
        "d"     #'org-babel-demarcate-block
        "t"     #'org-babel-tangle
        "f"     #'org-babel-tangle-file
        "c"     #'org-babel-check-src-block
        "j"     #'org-babel-insert-header-arg
        "l"     #'org-babel-load-in-session
        "i"     #'org-babel-lob-ingest
        "I"     #'org-babel-view-src-block-info
        "z"     #'org-babel-switch-to-session
        "Z"     #'org-babel-switch-to-session-with-code
        "a"     #'org-babel-sha1-hash
        "x"     #'org-babel-do-key-sequence-in-edit-buffer)

      (:prefix ("i" . "Insert")
        ;; insertion
        "b" #'org-insert-structure-template
        "d" #'org-insert-drawer
        "e" #'org-set-effort
        "f" #'org-footnote-new
        "h" #'org-insert-heading
        "H" #'org-insert-heading-after-current
        "i" #'org-insert-item
        "l" #'org-insert-link
        "n" #'org-add-note
        "p" #'org-set-property
        "s" #'org-insert-subheading
        "t" #'org-set-tags-command))

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

(map! :leader
      (:prefix ("j" . "Jump")
       )

      (:prefix ("h" . "help")
       (:prefix ("r" . "reload")
        "c"  #'slang/reload-config)))

(map! :map TeX-mode-map
      "C-c C-c"         #'slang/save-tex-file-and-build)

(map! :localleader
      :map TeX-mode-map

      "v"     #'TeX-view
      "b"     #'slang/save-tex-file-and-build
      "t"     #'reftex-toc
      "="     #'LaTeX-fill-section

      (:prefix ("f" . "format")
       "e"  #'LaTeX-fill-environment
       "p"  #'LaTeX-fill-paragraph
       "r"  #'LaTeX-fill-region
       "s"  #'LaTeX-fill-section))

(map! :localleader
      :map julia-mode-map
      "o"  #'+julia/open-repl
      "b"  #'julia-repl-send-buffer
      "l"  #'julia-repl-send-line
      "r"  #'julia-repl-send-region-or-line)

(map! :map pdf-view-mode-map
      "/"  nil
      "/"  #'pdf-occur)
