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

echo "listen_addresses = '0.0.0.0'" >> /var/lib/postgresql/data/postgresql.conf

# # Set environment variables for PostgreSQL
# POSTGRES_USER=postgres
# POSTGRES_PASSWORD=postgres
# POSTGRES_DB=postgres

# # Create a PostgreSQL user and database
# echo "CREATE DATABASE $POSTGRES_DB;" > /tmp/db.sql
# echo "CREATE USER $POSTGRES_USER WITH ENCRYPTED PASSWORD '$POSTGRES_PASSWORD';" >> /tmp/db.sql
# echo "GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER;" >> /tmp/db.sql
# pg_ctl start -D /var/lib/postgresql/data && psql -f /tmp/db.sql && pg_ctl stop -D /var/lib/postgresql/data

# Configure Redis to run in the background (optional)
sed -i 's/^# \(bind .*\)$/\1/' /etc/redis.conf
sed -i 's/^# \(protected-mode no\)$/\1/' /etc/redis.conf
echo 'daemonize yes' >> /etc/redis.conf


# starting supervisord
/app/supervisord