#!/bin/bash
sudo -i
sudo apt-get update
sudo apt-get install haproxy -y
sudo sed -i 's,^\(ENABLED=\).*,\1'1',' /etc/default/haproxy
echo "frontend haproxynode \nbind *:80 \nmode http \ndefault_backend backendnodes \nbackend backendnodes \nbalance roundrobin \nserver node2 10.1.0.5:80 check" >> /etc/haproxy/haproxy.cfg
sudo service haproxy restart
