#!/bin/bash
sudo -i
apt-get update
apt-get install haproxy
sed -i 's,^\(ENABLED=\).*,\1'1',' /etc/default/haproxy
echo "listen  00.0.0 0.0.0.0:80 \nmode http \nbalance roundrobin \nserver apache-1 $1:80 cookie s1 check" >> /etc/haproxy/haproxy.cfg
service haproxy restart
