# Fedora dnf aliases
alias dnfi="sudo dnf install"
alias dnfs="dnf search"
alias dnfr="sudo dnf remove"
alias dnfu="sudo dnf update && flatpak update"

alias grep="grep --color=auto"
alias eF="$EDITOR ~/.config/fish/config.fish"
alias rF=". ~/.config/fish/config.fish"
alias eZ="$EDITOR ~/.zshrc"
alias rZ="source ~/.zshrc"
alias reboot="sudo systemctl reboot"
alias poweroff="sudo systemctl poweroff"
alias i3config="$EDITOR ~/.config/i3/config"
alias xclip="xclip -selection c"
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

alias emacsclient-restart="systemctl --user restart emacs"
alias ec="emacsclient -nw"

# Better ls
if type -q exa
  alias ls='exa -l --group-directories-first --git --color auto'
else
  alias ls='ls -lh --color=auto --group-directories-first'
end

if type -q nvim
  # Always use neovim instead of vim
  alias vim=nvim
  # Use nvim for manpages
  export MANPAGER="nvim -c 'set ft=man' -"
end
