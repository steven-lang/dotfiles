# Use colored cat if available
if type -q ccat
  alias cat 'ccat'
end

# Aliases
alias df 'df -h'                          # human-readable sizes
alias free 'free -m'                      # show sizes in MB
alias np 'nano -w PKGBUILD'
alias more less

# Better ls
# alias ls 'ls -lh --color=auto --group-directories-first'
if type -q exa
  alias ls 'exa -1'
  alias ll 'exa -l --group-directories-first --git --color auto'
end
alias grep 'grep --color=auto'

# Pacman shortcuts
alias pacu 'sudo pacman -Syu && yay -Syua'
alias pacs 'sudo pacman -S'
alias yay 'yay --noconfirm'

# zshrc editing
alias eZ 'vim ~/.zshrc'
alias rZ 'source ~/.zshrc'
alias reboot 'sudo systemctl reboot'
alias poweroff 'sudo systemctl poweroff'

# i3-shortcuts
alias i3config 'vim ~/.config/i3/config'
alias i3statusconfig 'vim ~/.config/i3status/config'

# Fast terminal-directory navigation
alias xclip 'xclip -selection c'
alias clone 'termite -e "bash" 2>&1 >/dev/null & disown %1'
alias PWD 'echo (pwd) | xclip && pwd && echo "path copied"'
alias CD 'echo "cd (xclip -o)" && cd (xclip -o)'
alias :q 'exit'

alias img 'feh'
alias zathura 'zathura --fork'
alias pdf 'zathura --fork'

alias vimconfig 'vim ~/.vimrc'
alias vimupdate 'vim +PlugClean +PlugUpdate +UpdateRemoteRepositories +qa'
alias zshconfig 'vim ~/.zshrc'
alias zshreload 'source ~/.zshrc'
alias i3config 'vim ~/.config/i3/config'
alias xresourcesconfig 'vim ~/.Xresources'
alias xresourcesreload 'xrdb -merge ~/.Xresources'

alias gnome-screenshot 'gnome-screenshot -a'

alias envactivate 'source ./env/bin/activate'
alias find 'ag -g'

# Update all pip packages
alias pipupdate "pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"

