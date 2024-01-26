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
/app/oyster-keygen --secretpath /app/secp.sec

ls /app
which ollama

echo "start pull llama2"
# /usr/local/bin/ollama pull llama2
echo "complete pull llama2"

curl http://localhost:11434/api/generate -d '{
  "model": "llama2",
  "prompt":"Why is the sky blue?"
}'

# starting supervisord
/app/supervisord
