#!/usr/bin/env bash

set -euo pipefail

sudo dnf install git ansible -y

git clone https://github.com/sburba/dotfiles.git ~/.dotfiles

~/.dotfiles/reapply.sh
