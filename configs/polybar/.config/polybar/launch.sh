#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

function launch {
    # Launch bar1 and bar2
    if [ "$1" == "light" ]
    then
	      polybar -c $HOME/.config/polybar/light-config nord-top &
	      polybar -c $HOME/.config/polybar/light-config nord-down &
    else
	      polybar -c $HOME/.config/polybar/dark-config nord-top &
	      polybar -c $HOME/.config/polybar/dark-config nord-down &
    fi
}

if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m launch
    done
else
    launch
fi


echo "Bars launched..."
