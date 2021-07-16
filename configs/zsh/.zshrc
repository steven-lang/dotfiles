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


##################################
#  EXPORTS end                   #
##################################


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
#  PREZTO begin                  #
##################################

# if [[ ! -d $HOME/.zprezto ]]; then
#   git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
# fi

##################################
#  PREZTO end                    #
##################################


##################################
#  ZGEN begin                    #
##################################

if [[ ! -d "${HOME}/.zgen" ]]; then
  git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi

# load zgen
source "${HOME}/.zgen/zgen.zsh"

AUTOPAIR_INHIBIT_INIT=1

# if the init script doesn't exist
if ! zgen saved; then

  # specify plugins here
  # prezto options
  zgen prezto editor key-bindings 'emacs'
  zgen prezto prompt theme 'pure'

  # Load general plugins
  zgen load hlissner/zsh-autopair
  zgen load agkozak/zsh-z
  zgen load mafredri/zsh-async
  zgen load junegunn/fzf shell

  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-syntax-highlighting

  # Load Prezto
  zgen prezto

  # Load Prezto Modules
  zgen prezto git
  zgen prezto environment
  zgen prezto terminal
  zgen prezto editor
  zgen prezto history
  zgen prezto directory
  zgen prezto spectrum
  zgen prezto utility
  zgen prezto completion
  zgen prezto syntax-highlighting
  zgen prezto history-substring-search
  # zgen prezto autosuggestions
  zgen prezto prompt

  # generate the init script from plugins above
  zgen save
fi


ZSH_AUTOSUGGEST_STRATEGY=(history completion)

##################################
#  ZGEN end                      #
##################################


##################################
#  ZSH INTERNAL SETTINGS begin   #
##################################

# vi mode
bindkey -v
export KEYTIMEOUT=1

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search
bindkey "^F" forward-char


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


source ~/.bash_aliases

##################################
#  MISC end                      #
##################################

autopair-init
