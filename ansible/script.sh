#!/bin/bash
sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible -y 
sudo apt-get update  
sudo apt-get install ansible -y 
sudo apt-get install git awscli python-pip -y 

sudo pip install -U boto

sudo cp -rf /tmp/wordpress_ansible/* /etc/ansible/
sudo chmod +x /etc/ansible/devlopment/hosts
sudo chmod 600 /etc/ansible/mykeypair
