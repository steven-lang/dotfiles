#!/bin/bash - 
#===============================================================================
#
#          FILE: systemd-suspend.sh
# 
#         USAGE: ./systemd-suspend.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 03/25/2019 20:33
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#!/bin/sh
if [ "${1}" == "pre" ]; then
  # Before suspend
elif [ "${1}" == "post" ]; then
  # After suspend

  # Check if HDMI is connected
  if grep -q HDMI $(xrandr)
  then
    # Disable backlight if monitor is connected
    xbacklight -set 0
  else
    # Enable backlight if no HDMI monitor is connected
    xbacklight -set 100
  fi
fi

