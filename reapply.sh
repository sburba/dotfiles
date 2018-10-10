#!/usr/bin/env bash

set -euo pipefail

pushd ~/.dotfiles > /dev/null
ansible-playbook -K install.yml -i ansible/hosts
popd > /dev/null

