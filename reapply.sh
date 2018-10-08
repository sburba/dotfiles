#!/usr/bin/env bash

set -euo pipefail

pushd ~/.dotfiles
ansible-playbook -K install.yml -i ansible/hosts
popd

