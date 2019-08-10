#!/bin/bash - 
#===============================================================================
#
#          FILE: install-universal-ctags.sh
# 
#         USAGE: ./install-universal-ctags.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 01/02/2019 11:52
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
git clone https://github.com/universal-ctags/ctags/ /tmp/ctags
cd /tmp/ctags
./autogen.sh
./configure --prefix=$HOME
make
make install 

