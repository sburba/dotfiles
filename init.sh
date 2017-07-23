#!/usr/bin/env bash

set -eou pipefail

install_deb () {
    local executable_name=$1
    local url=$2

    # If it's already installed, don't install it again
    if hash $executable_name 2>/dev/null; then
        echo "$executable_name is already installed"
        return 0
    fi

    local deb_path=".downloads/${executable_name}.deb"
    # Same thing if it's already downloaded
    if [ ! -f "$deb_path" ]; then
        mkdir -p .downloads
        wget $url -O $deb_path
    fi

    echo "Installing $executable_name"
    yes | sudo gdebi $deb_path
}

header () {
    text=$1

    echo
    echo $text
    echo
}

header "Installing apps from the default repository"
sudo apt install vim git stow i3 compton rofi lxappearance feh gdebi

header "Installing special snowflake apps not in the default repo"
install_deb google-chrome-stable https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

header "Installing dotfiles"
# Run stow on every non-dot-prefixed directory in this dir
find * -maxdepth 0 -type d -exec stow {} \;

echo "Done"
