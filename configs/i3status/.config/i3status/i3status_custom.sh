#!/bin/sh
# shell script to prepend i3status with more stuff

i3status | while :
do
        text=$(/usr/bin/emacsclient --eval "(slang/org-clock-output-polybar)" 2&>1 && cat ~/tmp/org-clock-current-task)
        read line
        echo "$text | $line" || exit 1
done
