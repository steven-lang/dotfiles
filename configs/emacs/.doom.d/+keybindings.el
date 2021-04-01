;; Switch to other buffer with "SPC TAB"

;; Use F1 to open the agenda
(map! "<f1>" nil
      "<f1>" #'slang/switch-to-agenda)

;; Use F2 to open agenda selection
(map! "<f2>"
      #'org-agenda)

;; FIXED: Why is 'C-u' overwritte by default?
;; (map! "C-u"  #'evil-scroll-up)

(map! "C-S-h" #'evil-window-left
      "C-S-j" #'evil-window-down
      "C-S-k" #'evil-window-up
      "C-S-l" #'evil-window-right)

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

;; More sophisticated "paste"
(map! "M-p" #'helm-show-kill-ring)

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
      :leader (:prefix "b" :desc "Workspace Buffers" "b" #'+ivy/switch-workspace-buffer)
      :leader (:prefix "b" :desc "All Buffers" "B" #'+ivy/switch-buffer))


;; Windows
(map! :leader
      (:prefix "w"
       :desc "Maximize" "m" #'toggle-maximize-buffer
       "w"  #'ace-window
       "/" nil
       :desc "Split right"  "/" #'(lambda () (interactive)(evil-window-vsplit) (other-window 1))
       :desc "Split below"  "-" #'(lambda () (interactive)(evil-window-split) (other-window 1))))



;; Use avy for buffer wide jumps
(map! 
 :nv "s" nil
 (:prefix ("s" .  "jump")
  :nv "s"   #'+evil:swiper
  :nv "j"   #'avy-goto-line-below
  :nv "k"   #'avy-goto-line-above
  :nv "w"   #'avy-goto-word-0
  :nv "c"   #'avy-goto-char
  :nv "t"   #'avy-goto-char-timer))



;; Helper function to realod the full config
(map! :leader
      (:prefix ("h" . "help")
       (:prefix ("r" . "reload")
        "c"  #'slang/reload-config)))


;; Shortcut to find dotfiles
(map! :leader
      "fD"  nil
      :desc "Dotfiles"  "fD"  #'(lambda () (interactive) (doom-project-find-file "~/dotfiles"))
      :desc "PhD Org." "np" #'(lambda () (interactive) (doom-project-find-file "~/org/notes/phd")))
