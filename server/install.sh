#!/bin/bash
if [ "$EUID" -ne 0 ]; then
    echo "You need to run this script as root"
    exit 1
fi

apt install -y software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt install -y ansible

if (( "${?}" != 0 )); then
   echo "Updates were not successful."
   exit 1
fi

exit 0
