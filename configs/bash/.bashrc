#
# ~/.bashrc
#
# Go into zsh shell

#export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/.local/bin:$HOME/bin"

## Preferred editor for local and remote sessions
#if [[ -z $SSH_CONNECTION ]]; then
#  export TERM=xterm-color
#  export EDITOR=nvim
#  export VISUAL=nvim
#  alias vim=nvim
#  alias cat='ccat'
#else
#  export EDITOR=vim
#  export VISUAL=vim
#fi

#export JAVA_HOME=/usr/lib/jvm/java-10-openjdk
#export TERMINAL=termite
#export WEKA_HOME=$HOME/wekafiles
#export DOTFILES=$HOME/dotfiles

## fzf
#export FZF_DEFAULT_OPTS='--height 40% --border'
## DARKMODE flag for termite and vim
#export DARKMODE=1

## Add dir colors
#eval `dircolors ~/.config/dircolors-solarized.db`

## Maven java server debugging
##export MAVEN_OPTS=-agentlib:jdwp=transport=dt_socket,address=8000,server=y,suspend=n
#PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
#PATH="$HOME/bin:$PATH"
#PATH="$PATH:/usr/bin/julia"
#LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/"

## Eval keychain
#if [[ -z $SSH_CONNECTION ]]; then
#  eval $(keychain --eval --quiet id_rsa_mz id_rsa)
#fi

if [[ "$TERM" == *xterm* ]]; then
   exec zsh 
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
