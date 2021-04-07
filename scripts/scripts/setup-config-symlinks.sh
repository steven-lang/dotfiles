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
link "zsh" $dotfiles_dir/configs/zsh/.zshrc $HOME/.zshrc
link "i3" $dotfiles_dir/configs/i3 $HOME/.config/i3
link "i3status" $dotfiles_dir/configs/i3status $HOME/.config/i3status
link "vim" $dotfiles_dir/configs/vim/.vimrc $HOME/.vimrc
link "polybar" $dotfiles_dir/configs/polybar $HOME/.config/polybar
link "flake8" $dotfiles_dir/configs/flake/flake8 $HOME/.flake8
link "rofi" $dotfiles_dir/configs/rofi $HOME/.config/rofi
link "compton" $dotfiles_dir/configs/compton.conf $HOME/.config/compton.conf
link "pylint" $dotfiles_dir/configs/pylint/.pylintrc $HOME/.pylintrc
link "bash" $dotfiles_dir/configs/bash/.bashrc $HOME/.bashrc
link "emacs" $dotfiles_dir/configs/emacs/.spacemacs $HOME/.spacemacs
link "dircolors-gruvbox" $dotfiles_dir/configs/dircolors-gruvbox.db $HOME/.config/dircolors-gruvbox.db
link "termite" $dotfiles_dir/configs/termite/config $HOME/.config/termite/config
link "tmux" $dotfiles_dir/configs/tmux.conf $HOME/.tmux.conf
link "zathura" $dotfiles_dir/configs/zathura/zathurarc $HOME/.config/zathura/zathurarc
