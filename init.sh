#!/usr/bin/env bash

# Install apps
sudo apt install vim git stow i3 compton rofi lxappearance feh

# Run stow on every non-dot-prefixed directory in this dir
find * -maxdepth 0 -type d -exec stow {} \;
