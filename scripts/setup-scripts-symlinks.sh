#!/bin/bash - 
#===============================================================================
#
#          FILE: setup-scripts-symlinks.sh
# 
#         USAGE: ./setup-scripts-symlinks.sh 
# 
#   DESCRIPTION: Creates symlinks to all scripts in the dotfiles to the 
#                appropriate system files
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Steven Lang, 
#  ORGANIZATION: 
#       CREATED: 03/06/2019 10:49
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

function link {
	name=$1
	from=$2
	to=$3

	if [[ -L "$3" ]] || [[ -f "$3" ]]; then
		echo "Existing $1 script found. Removing"
		sudo rm $3
	fi
	sudo ln -s $2 $3
	echo "Created symlink:"
	echo "$2 -> $3"
}

dotfiles_dir="$HOME/dotfiles"

link "gscrot" $dotfiles_dir/scripts/gscrot /usr/local/bin/gscrot
link "gscrot-interactive" $dotfiles_dir/scripts/gscrot-interactive /usr/local/bin/gscrot-interactive
link "keyboard-de" $dotfiles_dir/scripts/keyboard-de.sh /usr/local/bin/keyboard-de
link "keyboard-us" $dotfiles_dir/scripts/keyboard-us.sh /usr/local/bin/keyboard-us
link "systemd-sleep-script" $dotfiles_dir/scripts/systemd-suspend.sh /usr/lib/systemd/system-sleep/systemd-suspend.sh
link "blacklist-webcam" $dotfiles_dir/scripts/nocam.conf /etc/modprobe.d/nocam.conf
