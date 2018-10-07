#!/usr/bin/env bash

set -euo pipefail

sudo dnf install git ansible -y

if [ ! -d ~/.dotfiles ]; then
  git clone https://github.com/sburba/dotfiles.git ~/.dotfiles
fi

pushd ~/.dotfiles
ansible-playbook -K install.yml
popd

