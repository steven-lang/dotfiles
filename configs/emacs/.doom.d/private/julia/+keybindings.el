(map! :localleader
      :map julia-mode-map
      "o"  #'+julia/open-repl
      "b"  #'julia-repl-send-buffer
      "l"  #'julia-repl-send-line
      "r"  #'julia-repl-send-region-or-line)
