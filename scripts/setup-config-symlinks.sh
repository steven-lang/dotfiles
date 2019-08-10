#!/bin/bash - 
#===============================================================================
#
#          FILE: setup-config-symlinks.sh
# 
#         USAGE: ./setup-config-symlinks.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#  ORGANIZATION: 
#       CREATED: 01/09/2019 22:08
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

function link {
	name=$1
	from=$2
	to=$3

	if [[ -L "$3" ]] || [[ -f "$3" ]]; then
		echo "Existing $1 config found. Creating backup with .bak extension ..."
		mv $3 $3.bak
	fi
	ln -s $2 $3
	echo "Created symlink:"
	echo "$2 -> $3"
}

dotfiles_dir="$HOME/dotfiles"

# Setup links 
link "zsh" $dotfiles_dir/config/zsh/.zshrc $HOME/.zshrc
link "i3" $dotfiles_dir/config/i3 $HOME/.config/i3
link "i3status" $dotfiles_dir/config/i3status $HOME/.config/i3status
link "vim" $dotfiles_dir/config/vim/.vimrc $HOME/.vimrc
link "polybar" $dotfiles_dir/config/polybar $HOME/.config/polybar
link "flake8" $dotfiles_dir/config/flake/flake8 $HOME/.flake8
link "rofi" $dotfiles_dir/config/rofi $HOME/.config/rofi
link "compton" $dotfiles_dir/config/compton.conf $HOME/.config/compton.conf
link "pylint" $dotfiles_dir/config/pylint/.pylintrc $HOME/.pylintrc
link "bash" $dotfiles_dir/config/bash/.bashrc $HOME/.bashrc
link "emacs" $dotfiles_dir/config/emacs/.spacemacs $HOME/.spacemacs
link "dircolors-gruvbox" $dotfiles_dir/config/dircolors-gruvbox.db $HOME/.config/dircolors-gruvbox.db
link "termite" $dotfiles_dir/config/termite/config $HOME/.config/termite/config
link "tmux" $dotfiles_dir/config/tmux.conf $HOME/.tmux.conf
link "zathura" $dotfiles_dir/config/zathura/zathurarc $HOME/.config/zathura/zathurarc
