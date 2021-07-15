if status is-interactive
    # Commands to run in interactive sessions can go here
    # eval (keychain --quiet --agents ssh id_rsa)
    # eval (keychain -Q --quiet id_rsa)
end

# Make errors bold-red
set fish_color_error red --bold

# Make menu selection background blue
set fish_color_search_match --background=blue

# Set fish done to 30s
set -U __done_min_cmd_duration 30000  # default: 5000 ms

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/tak/.conda/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

