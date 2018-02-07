#!/bin/bash
sudo -i
apt-get update
apt-get install haproxy -y
sed -i 's,^\(ENABLED=\).*,\1'1',' /etc/default/haproxy
echo "frontend haproxynode \nbind *:80 \nmode http \ndefault_backend backendnodes \nbackend backendnodes \nbalance roundrobin \nserver node2 10.1.0.5:80 check" >> /etc/haproxy/haproxy.cfg
service haproxy restart
