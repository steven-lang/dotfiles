# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Source antigen
source ~/antigen.zsh
antigen use oh-my-zsh
# plugins=(git git-flow-avh mvn gradle)
antigen bundle git
antigen bundle git-flow-avh
antigen bundle git-flow-mvn
antigen bundle gradle
# antigen bundle agkozak/zsh-z
antigen bundle z 
antigen bundle fzf
antigen bundle zsh-users/zsh-syntax-highlighting
# antigen theme bureau
antigen apply

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="gnzh"
ZSH_THEME="bureau"
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
source $ZSH/oh-my-zsh.sh

export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/.local/bin:$HOME/bin"
export TERM="xterm-256color"

# Preferred editor for local and remote sessions
if [[ -z $SSH_CONNECTION ]]; then
  export TERM=xterm-color
  export EDITOR=nvim
  export VISUAL=nvim
  alias vim=nvim
  alias cat='ccat'
else
  export EDITOR=vim
  export VISUAL=vim
fi

export JAVA_HOME=/usr/lib/jvm/java-10-openjdk
export TERMINAL=termite
export WEKA_HOME=$HOME/wekafiles
export DOTFILES=$HOME/dotfiles

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

# Better ls
alias ls='ls -lh --color=auto --group-directories-first'
alias grep='grep --color=auto'

# Pacman shortcuts
alias pacu='sudo pacman -Syu && yay -Syua'
alias pacs='sudo pacman -S'
alias yay='yay --noconfirm'
# Moved to update functions (see above)

# zshrc editing
alias eZ='vim ~/.zshrc'
alias rZ='source ~/.zshrc'
alias reboot='sudo systemctl reboot'
alias poweroff='sudo systemctl poweroff'
# Grub update - (currently systemd-boot -> no need for that)
#alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

# i3-shortcuts
alias i3config='vim ~/.config/i3/config'
alias i3statusconfig='vim ~/.config/i3status/config'

# Fast terminal-directory navigation
alias xclip='xclip -selection c'
alias PWD='echo $(pwd) | xclip && pwd && echo "path copied"'
alias CD='echo "cd $(xclip -o)" && cd $(xclip -o)'
alias :q='exit'

alias img='feh'
alias pdf='evince'
alias zathura='zathura --fork'

alias vimconfig='vim ~/dotfiles/config/vim/.vimrc'
alias vimupdate='vim +PlugClean +PlugUpdate +UpdateRemoteRepositories +qa'
alias zshconfig='vim ~/dotfiles/config/zsh/.zshrc'
alias zshreload='source ~/.zshrc'
alias i3config='vim ~/dotfiles/config/i3/config'
alias xresourcesconfig='vim ~/.Xresources'
alias xresourcesreload='xrdb -merge ~/.Xresources'

alias gnome-screenshot='gnome-screenshot -a'

alias envactivate='source ./env/bin/activate'


# Add dir colors
eval `dircolors ~/.config/dircolors-gruvbox.db`

# You may need to manually set your language environment
# export LANG=en_US.UTF-8


bindkey '^w' backward-kill-word
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search



# autoload -Uz add-zsh-hook

function xterm_title_precmd () {
	print -Pn '\e]2;%n@%m %1~\a'
}

function xterm_title_preexec () {
	print -Pn '\e]2;%n@%m %1~ %# '
	print -n "${(q)1}\a"
}

if [[ "$TERM" == (screen*|xterm*|rxvt*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

function toggle_darkmode() {
  f="$HOME/.zshrc"
  grep -q "export DARKMODE=1" $f && sed -i "s/export DARKMODE=1/export DARKMODE=0/g" $f || sed -i "s/DARKMODE=0/DARKMODE=1/g" $f
  source $f
}

if [[ ! -f $HOME/antigen.zsh ]]; then
    curl -L git.io/antigen > $HOME/antigen.zsh
fi

if [[ ! -d $HOME/zsh-syntax-highlighting ]]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/zsh-syntax-highlighting
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
