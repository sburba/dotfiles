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
    local key_url=$3

    local source_line="deb $source_url"
    local source_file="/etc/apt/sources.list.d/$friendly_name.list"

    sudo bash -c "echo $source_line > $source_file"

    wget -q "$key_url" -O- | sudo apt-key add -
}

header () {
    text=$1

    echo
    echo ${text}
    echo
}

header "Adding required 3rd party repositories"
add_apt_source enpass "http://repo.sinew.in/ stable main" https://dl.sinew.in/keys/enpass-linux.key

header "Installing apps from the default repository"
sudo apt update
sudo apt install vim vim-gtk git stow i3 compton rofi lxappearance feh gdebi enpass curl

header "Installing special snowflake apps not in the default repo"
install_deb google-chrome-stable https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

header "Setting up Enpass"
ln -fs /opt/Enpass/bin/runenpass.sh ~/.local/bin/enpass

header "Setting up gnome-terminal"
./monokai.dark.sh

header "Installing dotfiles"
# Run stow on every non-dot-prefixed directory in this dir
pushd stowables &>/dev/null
find * -maxdepth 0 -type d -exec stow --target=../../ "{}" \;
popd &>/dev/null

header "Setting up wallpaper"
if [ ! -f "~/Pictures/wallpaper.png" ]; then
    cp wallpapers/wallpaper.png ~/Pictures/wallpaper.png
fi

echo "Done"
