if status is-interactive
    # Commands to run in interactive sessions can go here
    # eval (keychain --quiet --agents ssh id_rsa)
    # eval (keychain -Q --quiet id_rsa)
end

# Make errors bold-red
set fish_color_error red --bold

# Make menu selection background blue
set fish_color_search_match --background=blue

# Enable vim mode
fish_vi_key_bindings

# Set fish done to 30s
set -U __done_min_cmd_duration 30000  # default: 5000 ms

