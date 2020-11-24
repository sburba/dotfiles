#!/usr/bin/env bash

set -euo pipefail

sudo apt update
sudo apt install git ansible python python-psutil -y

git clone https://github.com/sburba/dotfiles.git ~/.dotfiles

~/.dotfiles/reapply.sh
