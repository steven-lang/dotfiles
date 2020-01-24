# echo "Commands:"
# echo "- Edit in vim : <C-x><C-e>"
# echo "- Correct last command in editor: fc"
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Download antigen if not present
if [[ ! -f $HOME/antigen.zsh ]]; then
    curl -L git.io/antigen > $HOME/antigen.zsh
fi

# Source antigen
source ~/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen bundle git-flow-avh
antigen bundle git-flow-mvn
antigen bundle gradle
antigen bundle z 
antigen bundle fzf
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
# antigen theme bureau
antigen apply

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="gnzh"
# ZSH_THEME="bureau"
# ZSH_THEME="amuse"

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

# export MANPATH="/usr/local/man:$MANPATH"
# EXPORTS #
# source $ZSH/oh-my-zsh.sh

export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/.local/bin:$HOME/bin/:$HOME/.cargo/bin/:/opt/android-sdk/platform-tools/"
export TERM="xterm-256color"

# Use colored cat if available
if hash ccat 2>/dev/null; then
  alias cat='ccat'
fi


# Check if nvim is available
if hash nvim 2>/dev/null; then
  # export EDITOR=nvim
  # export VISUAL=nvim
  alias vim=nvim

  # Use nvim for manpages
  export MANPAGER="nvim -c 'set ft=man' -"
else
  # export EDITOR=vim
  # export VISUAL=vim
fi
export EDITOR=emacsclient
export VISUAL=emacsclient

export JAVA_HOME=/usr/lib/jvm/java-10-openjdk
export TERMINAL=termite
export WEKA_HOME=$HOME/wekafiles
export DOT=$HOME/dotfiles
export LD_LIBRARY_PATH="/usr/local/cuda-10.1/lib64"

# fzf
export FZF_DEFAULT_OPTS='--height 40% --border'
export FZF_DEFAULT_COMMAND='ag -g .'

# Maven java server debugging
#export MAVEN_OPTS=-agentlib:jdwp=transport=dt_socket,address=8000,server=y,suspend=n
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
PATH="$HOME/bin:$PATH"
PATH="$PATH:/usr/bin/julia"
PATH="$PATH:$HOME/.emacs.d/bin"
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/"

# Eval keychain only locally
if [[ -z $SSH_CONNECTION ]]; then
  eval $(keychain --eval --quiet id_rsa_mz id_rsa)
fi

# Aliases
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

# Emacs client
function emacsclient() {
    /usr/bin/emacsclient -c -a '' "$@" &
    disown
}
alias ec="/usr/bin/emacsclient -nw -c -a '' "$@""
# alias ec="emacsclient -n"
alias emacsclient-restart="systemctl --user restart emacs"

# Better ls
# alias ls='ls -lh --color=auto --group-directories-first'
if hash exa 2>/dev/null; then
  alias ls='exa -l --group-directories-first --git --color auto'
fi

alias grep='grep --color=auto'
alias pacu='sudo pacman -Syu && yay -Syua'
alias pacs='sudo pacman -S'
alias yay='yay --noconfirm'
alias eZ='$EDITOR ~/.zshrc'
alias rZ='source ~/.zshrc'
alias reboot='sudo systemctl reboot'
alias poweroff='sudo systemctl poweroff'
alias i3config='$EDITOR ~/.config/i3/config'
alias i3statusconfig='$EDITOR ~/.config/i3status/config'
alias xclip='xclip -selection c'
alias clone='termite -e "bash" 2>&1 >/dev/null & disown %1'
alias PWD='echo $(pwd) | xclip && pwd && echo "path copied"'
alias CD='echo "cd $(xclip -o)" && cd $(xclip -o)'
alias :q='exit'
alias zathura='zathura --fork'
alias vimconfig='$EDITOR ~/.vimrc'
alias vimupdate='vim +PlugClean +PlugUpdate +UpdateRemoteRepositories +qa'
alias zshconfig='$EDITOR ~/.zshrc'
alias zshreload='source ~/.zshrc'
alias i3config='$EDITOR ~/.config/i3/config'
alias xresourcesconfig='$EDITOR ~/.Xresources'
alias xresourcesreload='xrdb -merge ~/.Xresources'
alias gnome-screenshot='gnome-screenshot -a'
alias envactivate='source ./env/bin/activate'

# Update all pip packages
alias pipupdate="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Emacs bindings
# bindkey '^w' backward-kill-word
# bindkey '^a' beginning-of-line
# bindkey '^e' end-of-line

# # Make CTRL-P/N behave like UP/DOWN arrows
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

bindkey '^r' history-incremental-search-backward

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search



# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Open pdfs in background by default
function pdf() {
  evince "$@" &
  disown
}

# Open images in background by default
function img() {
  eog "$@" &
  disown
}

# Check for virtual environments when cd'ing into directories
function cd() {
  builtin cd "$@"

  if [[ -z "$VIRTUAL_ENV" ]] ; then
    ## If env folder is found then activate the vitualenv
      if [[ -d ./env ]] ; then
        source ./env/bin/activate
        echo -e "Python virtual environment activated!"
      fi
      if [[ -d ./venv ]] ; then
        source ./venv/bin/activate
        echo -e "Python virtual environment activated!"
      fi
  else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate
      parentdir="$(dirname "$VIRTUAL_ENV")"
      if [[ "$PWD"/ != "$parentdir"/* ]] ; then
        deactivate
      fi
  fi
}


# Check if direnv is installed
if [ ! -f $HOME/bin/direnv ]; then
  echo "Direnv not found. Installing now ..."
  wget -O $HOME/bin/direnv https://github.com/direnv/direnv/releases/download/v2.20.0/direnv.linux-amd64 > /dev/null
  chmod +x $HOME/bin/direnv
fi


# Enable direnv
eval "$(direnv hook zsh)"

# Remove history duplicates
setopt HIST_IGNORE_ALL_DUPS

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# Enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)
