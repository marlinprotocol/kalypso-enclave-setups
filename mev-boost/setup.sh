#!/bin/sh

# setting an address for loopback
ifconfig lo 127.0.0.1
ifconfig

# adding a default route
ip route add default via 127.0.0.1 dev lo
route -n

# iptables rules to route traffic to transparent proxy
iptables -A OUTPUT -t nat -p tcp --dport 1:65535 ! -d 127.0.0.1  -j DNAT --to-destination 127.0.0.1:1200
iptables -t nat -A POSTROUTING -o lo -s 0.0.0.0 -j SNAT --to-source 127.0.0.1
iptables -L -t nat

# generate identity key
/app/keygen --secret /app/id.sec --public /app/id.pub
/app/oyster-keygen --secret /app/secp.sec --public /app/secp.pub

ls app

/app/postgresSetup.sh
# starting supervisord
LISTEN_ADDR=0.0.0.0 BEACON_URIS=http://46.4.77.113:5052 /app/supervisord