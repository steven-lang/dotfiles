# Fedora dnf aliases
alias dnfi="sudo dnf install"
alias dnfs="dnf search"
alias dnfr="sudo dnf remove"
alias dnfu="sudo dnf update && flatpak update"

alias grep="grep --color=auto"
alias eZ="$EDITOR ~/.zshrc"
alias rZ="source ~/.zshrc"
alias reboot="sudo systemctl reboot"
alias poweroff="sudo systemctl poweroff"
alias i3config="$EDITOR ~/.config/i3/config"
# alias xclip="xclip -selection c"
alias clone="termite -e 'bash' 2>&1 >/dev/null & disown %1"
alias PWD="echo $(pwd) | xclip && pwd && echo 'path copied'"
alias CD="echo 'cd $(xclip -o)' && cd $(xclip -o)"
alias :q="exit"
alias vimconfig="$EDITOR ~/.vimrc"
alias vimupdate="vim +PlugClean +PlugUpdate +UpdateRemoteRepositories +qa"
alias zshconfig="$EDITOR ~/.zshrc"
alias zshreload="source ~/.zshrc"
alias i3config="$EDITOR ~/.config/i3/config"
alias xresourcesconfig="$EDITOR ~/.Xresources"
alias xresourcesreload="xrdb -merge ~/.Xresources"
alias rsync="rsync --archive --compress-level=3 --copy-links --partial --inplace --progress --rsh=ssh -r"
alias tlmgr="/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode"

# Update all pip packages
alias pipupdate="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"

# ALIASES
alias emacsclient-restart="systemctl --user restart emacs"

# Better ls
if hash exa 2>/dev/null; then
  alias ls='exa -l --group-directories-first --git --color auto'
else
  alias ls='ls -lh --color=auto --group-directories-first'
fi
