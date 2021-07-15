#
# ~/.bashrc
#
# Go into zsh shell


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Eval keychain only locally
# NOTE: This needs to be done after the interactive if-statement
if [[ -z $SSH_CONNECTION ]]; then
  eval $(keychain --eval --quiet id_rsa)
fi

# Go into zsh
if [[ $(ps --no-header --pid=$PPID --format=cmd) != "zsh" ]]; then
  exec zsh
fi
