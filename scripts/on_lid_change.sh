#!/usr/bin/env bash

laptop_screen=$(xrandr | grep "connected primary" | cut -d " " -f 1)
external_screen=$(xrandr | grep " connected" | grep -v primary | cut -d " " -f 1)
lid_open=$(cat /proc/acpi/button/lid/LID0/state | grep open)


if [[ ! ${external_screen} ]]; then
    echo "auto"
    xrandr --auto
elif [[ ${lid_open} ]]; then
    echo "docked open"
    ~/.screenlayout/docked-open.sh
else
    echo "docked closed"
    ~/.screenlayout/docked-closed.sh
fi

