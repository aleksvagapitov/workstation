#!/bin/bash
sudo apt install -y software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

sudo ansible-playbook local.yml
cd ~/.dotfiles/ansible && ansible-playbook -e "ansible_become_password=user" local.yml 

exit 0
