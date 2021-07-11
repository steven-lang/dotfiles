# echo "Commands:"
# echo "- Edit in vim : <C-x><C-e>"
# echo "- Correct last command in editor: fc"
# Path to your oh-my-zsh installation.

# if [ "$TMUX" = "" ]; then
#   tmux
# fi

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
# zplug "sindresorhus/pure"
zplug "junegunn/fzf", use:"shell/*.zsh"
zplug "hlissner/zsh-autopair", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2
# zplug "zsh-users/zsh-syntax-highlighting"
zplug "zdharma/fast-syntax-highlighting", defer:2
zplug "softmoth/zsh-vim-mode"
zplug "zsh-users/zsh-completions"
zplug "kutsan/zsh-system-clipboard"
zplug "mafredri/zsh-async", defer:3
zplug "agkozak/zsh-z"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="gnzh"
# ZSH_THEME="bureau"
# ZSH_THEME="amuse"
ZSH_THEME=""

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git git-flow-avh mvn gradle)

# User configuration




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


# Enable edit- in commandline
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line


# Enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)
[ -f ~/.conda/etc/profile.d/conda.sh ] && source ~/.conda/etc/profile.d/conda.sh

MODE_CURSOR_VICMD="green block"
MODE_CURSOR_VIINS="#20d08a blinking bar"
MODE_CURSOR_SEARCH="#ff00ff blinking underline"

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# Enable direnv
eval "$(direnv hook zsh)"
