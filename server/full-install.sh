#!/bin/bash

# Fix Ubuntu 22.04 Unattended Installation 
echo "\$nrconf{restart} = 'a';" | sudo tee /etc/needrestart/conf.d/50local.conf

sudo apt install -y software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

SERVER_INSTALL_START=$(date "+%s")
sudo ansible-playbook local.yml
SERVER_INSTALL_END=$(date "+%s") 

DOTFILES_INSTALL_START=$(date "+%s")
cd ~/.dotfiles/ansible && ansible-playbook -e "ansible_become_password=user" local.yml 
DOTFILES_INSTALL_END=$(date "+%s")

echo "Server Install time: " $((SERVER_INSTALL_END-SERVER_INSTALL_START))
echo "Dotfiles Install time: " $((DOTFILES_INSTALL_END-DOTFILES_INSTALL_START))

exit 0
