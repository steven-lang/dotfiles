;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; This is where you install packages, by declaring them with the `package!'
;; macro, then running 'doom refresh' on the command line. You'll need to
;; restart Emacs for your changes to take effect! Or at least, run M-x
;; `doom/reload'.
;;
;; WARNING: Don't disable core packages listed in ~/.emacs.d/core/packages.el.
;; Doom requires these, and disabling them may have terrible side effects.
;;
;; Here are a couple examples:


;; All of Doom's packages are pinned to a specific commit, and updated from
;; release to release. To un-pin all packages and live on the edge, do:
                                        ;(setq doom-pinned-packages nil)

;; ...but to unpin a single package:
                                        ;(package! pinned-package :pin nil)


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
                                        ;(package! some-package)

;; To install a package directly from a particular repo, you'll need to specify
;; a `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
                                        ;(package! another-package
                                        ;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
                                        ;(package! this-package
                                        ;  :recipe (:host github :repo "username/repo"
                                        ;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, for whatever reason,
;; you can do so here with the `:disable' property:
                                        ;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
                                        ;(package! builtin-package :recipe (:nonrecursive t))
                                        ;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
                                        ;(package! builtin-package :recipe (:branch "develop"))


;; Misc
;; (package! mu4e)
;; (package! mu4e-alert)
;; (package! edit-server)
(package! blacken)

;; If you want to replace it with yasnippet's default snippets
(package! yasnippet-snippets)
(package! lorem-ipsum)
(package! ssh-agency)
(package! aggressive-indent)
;; (package! mixed-pitch)
;; (package! lsp-julia :recipe (:host github :repo "non-jedi/lsp-julia"))
(package! cuda-mode)
(package! dockerfile-mode)
(package! yaml-mode)
(package! rainbow-mode)
;; (package! circadian)
(package! py-pyment :recipe (:host github :repo "humitos/py-cmd-buffer.el"))
(package! buftra :recipe (:host github :repo "humitos/buftra.el"))  ;; py-pyment dependency!

;; (package! counsel-gtags)
;; (package! global-tags)

;; Themes
(package! modus-operandi-theme)
(package! modus-vivendi-theme)

;; Helm
(package! helm)

;; Disable packages
(package! evil-snipe :disable t)

;; Org stuff
; (package! org-ref)
(package! org-gcal)
(package! org-super-agenda)
(package! org-ql)
(package! org-pomodoro)
(package! org-fragtog)
(package! org-noter)
(package! org-superstar)

(package! org-roam-bibtex)
(package! org-ref)
(package! ivy-bibtex)
;; When using org-roam via the `+roam` flag
;; (unpin! org-roam company-org-roam)

;; Collection of Ridiculously Useful eXtensions for Emacs
(package! crux)
