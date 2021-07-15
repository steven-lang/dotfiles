function fish_user_key_bindings
    bind -M insert \cp up-or-search
    bind -M insert \cn down-or-search
    bind -M insert \cf forward-char
    set -g fish_key_bindings fish_vi_key_bindings
end
