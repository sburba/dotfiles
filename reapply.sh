#!/usr/bin/env bash

set -euo pipefail

pushd ~/.dotfiles > /dev/null
ansible-galaxy install -r ansible/requirements.yml
ansible-playbook -K ansible/install.yml -i ansible/hosts
popd > /dev/null

