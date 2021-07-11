# Make cursor line/block etc in different vim modes
function fish_mode_prompt
  switch $fish_bind_mode
    case default
      echo -en "\e[2 q"
      set_color -o brwhite
      echo "[ "
      set_color -o brred
      echo "N"
      set_color -o brwhite
      echo " ]"
    case insert
      echo -en "\e[6 q"
      set_color -o brwhite
      echo "[ "
      set_color -o brgreen
      echo "I"
      set_color -o brwhite
      echo " ]"
    case replace_one
      echo -en "\e[4 q"
      set_color -o brwhite
      echo "[ "
      set_color -o bryellow
      echo "R"
      set_color -o brwhite
      echo " ]"
    case visual
      echo -en "\e[2 q"
      set_color -o brwhite
      echo "[ "
      set_color -o brmagenta
      echo "V"
      set_color -o brwhite
      echo " ]"
    case '*'
      echo -en "\e[2 q"
      set_color -o brwhite
      echo "[ "
      set_color -o brred
      echo "?"
      set_color -o brwhite
      echo " ]"
  end
  set_color normal
end
