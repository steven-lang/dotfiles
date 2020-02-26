
(general-def TeX-mode-map
  :states '(normal emacs)
  :prefix ","

  "ie"  'latex-insert-block
  "b"   'latex/build
  "v"   'TeX-view
  )
