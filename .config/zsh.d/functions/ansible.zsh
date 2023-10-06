# -*- mode: sh -*-
if [ -d ~/Ansible/ansible/hacking/env-setup ]; then
    source ~/Ansible/ansible/hacking/env-setup -q
fi

if [ -d ~/Ansible ]; then
    export ANSIBLE_INVENTORY=~/Ansible/hosts
fi
