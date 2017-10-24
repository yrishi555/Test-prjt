#!/bin/bash
set -x
apt-get update
apt-get install ansible -y
echo "[wordpress] \n10.1.1.21  ansible_connection=local" >> /root/hosts
wget https://raw.githubusercontent.com/yrishi555/Test-prjt/master/install_docker.yml
ansible-playbook -i /root/hosts install_docker.yml
