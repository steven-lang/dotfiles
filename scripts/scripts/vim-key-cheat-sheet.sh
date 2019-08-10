#!/bin/bash - 
#===============================================================================
#
#          FILE: vim-key-cheat-sheet.sh
# 
#         USAGE: ./vim-key-cheat-sheet.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 01/09/2019 09:40
#      REVISION:  ---
#===============================================================================

urxvt -title "cheatsheet" -e sh -c "less ~/dotfiles/config/vim/keys.txt; exec bash"

