#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

install_deb () {
    local executable_name=$1
    local url=$2

    # If it's already installed, don't install it again
    if hash "${executable_name}" 2>/dev/null; then
        echo "$executable_name is already installed"
        return 0
    fi

    local deb_path=".downloads/${executable_name}.deb"
    # Same thing if it's already downloaded
    if [ ! -f "$deb_path" ]; then
        mkdir -p .downloads
        wget "${url}" -O "${deb_path}"
    fi

    echo "Installing $executable_name"
    yes | sudo gdebi "${deb_path}"
}

add_apt_source () {
    local friendly_name=$1
    local source_url=$2
    local key_url_1=$3
    local key_url_2=$4

    local source_line="deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib"
    if grep -Fxq "$source_line" /etc/apt/sources.list; then
        echo "$source_url is already in the sources list"
    else
        sudo bash -c 'cat >> /etc/apt/sources.list' << EOF
# Apt Repository for $friendly_name
deb $source_url $(lsb_release -sc) contrib
EOF
    fi

    wget -q "$key_url_1" -O- | sudo apt-key add -
    wget -q "$key_url_2" -O- | sudo apt-key add -
}

header () {
    text=$1

    echo
    echo ${text}
    echo
}

header "Installing apps from the default repository"
sudo apt install vim git stow i3 compton rofi lxappearance feh gdebi

header "Installing special snowflake apps not in the default repo"
install_deb google-chrome-stable https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

header "Setting up gnome-terminal"
./monokai.dark.sh

header "Installing dotfiles"
# Run stow on every non-dot-prefixed directory in this dir
find * -maxdepth 0 -type d -exec stow "{}" \;

echo "Done"
