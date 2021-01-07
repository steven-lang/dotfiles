;; -*- no-byte-compile: t; -*-

;; Themes
(package! modus-operandi-theme)
(package! modus-vivendi-theme)

;; Show colors as character background
(package! rainbow-mode)

;; Change the theme based on the time or location for day/night modes
(when (featurep! +circadian)
        (package! circadian))
