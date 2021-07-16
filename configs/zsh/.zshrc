

##################################
#  EXPORTS begin                 #
##################################

# Check if nvim is available
if command -v nvim &>/dev/null; then
  # Use nvim for manpages
  export MANPAGER="nvim -c 'set ft=man' -"
fi


# Emacsclient as (sudo-)editor
export EDITOR="emacsclient -nw"
export SUDO_EDITOR="emacsclient -nw"

# FZF options
export FZF_DEFAULT_OPTS='--height 40% --border'
export FZF_DEFAULT_COMMAND='ag -g .'

# Add ruby binaries to path if available
if command -v ruby &> /dev/null; then
  PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
fi

# Extend $PATH
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/dotbin"  # scripts from dotfiles
export PATH="$HOME/bin:$PATH"  # local binaries
export PATH="$PATH:$HOME/.emacs.d/bin" # doom binaries
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"  # yarn

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/"

# Fixes some terminal application colors
export TERM="xterm-256color"

# Set history file
export HISTFILE=$HOME/.zsh_history
# number of lines kept in history
export HISTSIZE=10000
# number of lines saved in the history after logout
export SAVEHIST=10000



# ???
# export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/.local/bin:$HOME/bin/:$HOME/.cargo/bin/:/opt/android-sdk/platform-tools/"

##################################
#  EXPORTS end                   #
##################################


source ~/.bash_aliases

# Start tmux in ssh connections
if [[ $SSH_CONNECTION ]]; then
  if [ "$TMUX" = "" ]; then
    tmux
  fi
fi




##################################
#  INSTALL BINARIES begin        #
##################################

# Ensure pip is installed
if ! command -v pip &> /dev/null; then
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

# Check if tpm is installed
if [ ! -d $HOME/.tmux/plugins/tpm ]; then
  echo "Tmux plugin manager not found. Installing now ..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi


# Download and install fzf
if [[ ! -d $HOME/.fzf ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

##################################
#  INSTALL BINARIES end          #
##################################


##################################
#  ZPLUG begin                   #
##################################

# Download and install zplug
if [[ ! -d $HOME/.zplug ]]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

source ~/.zplug/init.zsh

# ZPLUG plugin loading
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "plugins/git",   from:oh-my-zsh

zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "junegunn/fzf", use:"shell/*.zsh"
zplug "hlissner/zsh-autopair", defer:2
# zplug "marlonrichert/zsh-autocomplete"
# zplug "zdharma/fast-syntax-highlighting", defer:2
zplug "softmoth/zsh-vim-mode"
zplug "zsh-users/zsh-completions"
zplug "kutsan/zsh-system-clipboard"
zplug "agkozak/zsh-z"
zplug "esc/conda-zsh-completion"

# zsh users
zplug "zsh-users/zsh-completions",              defer:0
zplug "zsh-users/zsh-autosuggestions",          defer:2, on:"zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting",      defer:3, on:"zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:3, on:"zsh-users/zsh-syntax-highlighting"


if command -v notify-send &> /dev/null; then
  zplug "MichaelAquilina/zsh-auto-notify"
fi

# NOTE: needs to come last
zplug "mafredri/zsh-async", from:"github", use:"async.zsh"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# Auto-notify settings
export AUTO_NOTIFY_THRESHOLD=30
AUTO_NOTIFY_IGNORE+=("eog" "docker")

# Vim mode cursor settings
MODE_CURSOR_VICMD="green block"
MODE_CURSOR_VIINS="#20d08a blinking bar"
MODE_CURSOR_SEARCH="#ff00ff blinking underline"

##################################
#  ZPLUG end                     #
##################################




##################################
#  ZSH INTERNAL SETTINGS begin   #
##################################

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Load widgets for ctrl-P, ctrl-N
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Set word style
autoload -U select-word-style
select-word-style bash

# Make completion selection as menu and match case insensitive
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Remove history duplicates
setopt HIST_IGNORE_ALL_DUPS

# append command to history file once executed
setopt inc_append_history
# Automatically use cd when paths are entered without cd
setopt autocd



##################################
#  ZSH INTERNAL SETTINGS end   #
##################################



##################################
#  MISC begin                    #
##################################

# Enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.conda/etc/profile.d/conda.sh ] && source ~/.conda/etc/profile.d/conda.sh

# Enable direnv
eval "$(direnv hook zsh)"

##################################
#  MISC end                      #
##################################
