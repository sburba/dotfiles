#!/usr/bin/env bash

#set -euo pipefail

xrandr_output=$(xrandr)
laptop_screen=$($xrandr_output | grep "connected primary" | cut -d " " -f 1)
all_other_screens=$(xrandr | grep " connected" | grep -v "primary" | cut -d " " -f 1)
lid_open=$(cat /proc/acpi/button/lid/LID0/state | grep open)

xrandr_args=""

for screen in $all_screens; do
    xrandr_args+="--output $screen --auto"
done

if [[ $lid_open ]]; then
    xrandr_args+="--output $laptop_screen --auto"
else
    xrandr_args+="--output $laptop_screen --off"
fi

echo "xrandr $xrandr_args" >> /var/log/lid_change.log

xrandr $xrandr_args

