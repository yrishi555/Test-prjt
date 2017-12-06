#!/bin/bash
sudo -i
apt-get update
apt-get install apache2 -y
echo "<VirtualHost *:80> \nServerAlias * \nRedirect / http://$1 \n</VirtualHost> \n<VirtualHost *:80> \nServerName $1 \n</VirtualHost>" >> /etc/apache2/apache2.conf
service apache2 restart
