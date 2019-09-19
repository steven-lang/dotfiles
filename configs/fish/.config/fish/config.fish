# Bootstrap Oh-My-Fish
if not type -q omf then
  git clone https://github.com/oh-my-fish/oh-my-fish
  ./oh-my-fish/bin/install --offline
end

# Exports
set -x PATH "$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/.local/bin:$HOME/bin/:$HOME/.cargo/bin/:/opt/android-sdk/platform-tools/"
set -x TERM "xterm-256color"

# Check if nvim is available
if type -q nvim then
  set -x EDITOR nvim
  set -x VISUAL nvim
  alias vim nvim

  # Use nvim for manpages
  set -x MANPAGER "nvim -c 'set ft=man' -"
else
  set -x EDITOR vim
  set -x VISUAL vim
end

set -x JAVA_HOME /usr/lib/jvm/java-10-openjdk
set -x TERMINAL termite
set -x WEKA_HOME $HOME/wekafiles
set -x DOT $HOME/dotfiles

# fzf
set -x FZF_DEFAULT_OPTS '--height 40% --border'
set -x FZF_DEFAULT_COMMAND 'ag -g .'

# Maven java server debugging
#set -x MAVEN_OPTS -agentlib:jdwp=transport=dt_socket,address=8000,server=y,suspend=n
set -x PATH "(ruby -e 'print Gem.user_dir')/bin:$PATH"
set -x PATH "$HOME/bin:$PATH"
set -x PATH "$PATH:/usr/bin/julia"
set -x PATH "$PATH:$HOME/.emacs.d/bin"
set -x LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/usr/lib/"


# Eval keychain only locally
# if test -z $SSH_CONNECTION; then
  # keychain --eval --quiet id_rsa_mz id_rsa
  # eval (ssh-agent -c)
# end

set -x theme_color_scheme gruvbox

source $HOME/.config/fish/aliases.fish
