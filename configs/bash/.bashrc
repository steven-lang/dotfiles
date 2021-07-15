#
# ~/.bashrc
#
# Go into zsh shell

#export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/.local/bin:$HOME/bin"


# Ensure pip is installed
if ! hash pip 2>/dev/null; then
  curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
  python3 /tmp/get-pip.py
fi

# Check if direnv is installed
if [ ! -f $HOME/bin/direnv ]; then
  echo "Direnv not found. Installing now ..."
  mkdir -p $HOME/bin
  wget -O $HOME/bin/direnv https://github.com/direnv/direnv/releases/download/v2.20.0/direnv.linux-amd64 > /dev/null
  chmod +x $HOME/bin/direnv
fi

# Check if direnv is installed
if [ ! -d $HOME/.tmux/plugins/tpm ]; then
  echo "Tmux plugin manager not found. Installing now ..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

export TERM="xterm-256color"
export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/.local/bin:$HOME/bin/:$HOME/.cargo/bin/:/opt/android-sdk/platform-tools/"


# Check if nvim is available
if hash nvim 2>/dev/null; then
  # Use nvim for manpages
  export MANPAGER="nvim -c 'set ft=man' -"
fi

# Set the proper editor
# if hash nvim 2>/dev/null; then
#   export EDITOR=nvim
#   export VISUAL=nvim
# else
#   export EDITOR=vim
#   export VISUAL=vim
# fi
export EDITOR="emacsclient -nw"
export SUDO_EDITOR="emacsclient -nw"

# fzf
export FZF_DEFAULT_OPTS='--height 40% --border'
export FZF_DEFAULT_COMMAND='ag -g .'


if hash ruby 2>/dev/null; then
  PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
fi

export PATH="$HOME/bin:$PATH"
export PATH="$PATH:/usr/bin/julia"
export PATH="$PATH:$HOME/.emacs.d/bin"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/"

export PATH="$PATH:$HOME/.conda/bin/"
[ -f ~/.conda/etc/profile.d/conda.sh ] && source ~/.conda/etc/profile.d/conda.sh


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Eval keychain only locally
# NOTE: This needs to be done after the interactive if-statement
if [[ -z $SSH_CONNECTION ]]; then
  eval $(keychain --eval --quiet id_rsa)
fi


if [[ $(ps --no-header --pid=$PPID --format=cmd) != "zsh" ]]; then
  exec zsh
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/$HOME/.conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/$HOME/.conda/etc/profile.d/conda.sh" ]; then
        . "/home/$HOME/.conda/etc/profile.d/conda.sh"
    else
        export PATH="/home/$HOME/.conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

