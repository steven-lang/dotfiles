# echo "Commands:"
# echo "- Edit in vim : <C-x><C-e>"
# echo "- Correct last command in editor: fc"
# Path to your oh-my-zsh installation.

# if [ "$TMUX" = "" ]; then
#   tmux
# fi

source ~/.bash_aliases

autoload -U select-word-style
select-word-style bash

export ZSH=$HOME/.oh-my-zsh


# Download and install fzf
if [[ ! -d $HOME/.fzf ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

# Download and install zgen
if [[ ! -d $HOME/.zplug ]]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

source ~/.zplug/init.zsh

# ZPLUG plugin loading
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-history-substring-search"
zplug "plugins/git",   from:oh-my-zsh

zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "junegunn/fzf", use:"shell/*.zsh"
zplug "hlissner/zsh-autopair", defer:2
# zplug "marlonrichert/zsh-autocomplete"
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-syntax-highlighting"
# zplug "zdharma/fast-syntax-highlighting", defer:2
zplug "softmoth/zsh-vim-mode"
zplug "zsh-users/zsh-completions"
zplug "kutsan/zsh-system-clipboard"
zplug "agkozak/zsh-z"
zplug "MichaelAquilina/zsh-auto-notify"
zplug "esc/conda-zsh-completion"

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

export AUTO_NOTIFY_THRESHOLD=30


# vi mode
bindkey -v
export KEYTIMEOUT=1

# Load widgets for ctrl-P, ctrl-N
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Remove history duplicates
setopt HIST_IGNORE_ALL_DUPS

# Set history file
export HISTFILE=$HOME/.zsh_history

# Enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.conda/etc/profile.d/conda.sh ] && source ~/.conda/etc/profile.d/conda.sh

MODE_CURSOR_VICMD="green block"
MODE_CURSOR_VIINS="#20d08a blinking bar"
MODE_CURSOR_SEARCH="#ff00ff blinking underline"

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Enable direnv
eval "$(direnv hook zsh)"
