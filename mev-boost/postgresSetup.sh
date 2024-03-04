#!/bin/sh

# Initialize the database
postgresql-setup initdb

# Modify postgresql.conf to listen on all addresses
POSTGRESQL_CONF="/var/lib/postgresql/data/postgresql.conf"
echo "listen_addresses='*'" >> "$POSTGRESQL_CONF"

# Modify the pg_hba.conf file for md5 password authentication for IPv4 and IPv6
PG_HBA_CONF="/var/lib/postgresql/data/pg_hba.conf"
echo "host    all             all             0.0.0.0/0               md5" >> "$PG_HBA_CONF"
echo "host    all             all             ::/0                    md5" >> "$PG_HBA_CONF"

# Start and enable PostgreSQL service
rc-service postgresql start
rc-update add postgresql default

# Wait for PostgreSQL to start
sleep 5

# Create a user and a database
su - postgres -c "psql -c \"CREATE USER postgres WITH ENCRYPTED PASSWORD 'postgres';\""
su - postgres -c "psql -c \"CREATE DATABASE postgres;\""
su - postgres -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE postgres TO postgres;\""

# Restart PostgreSQL to apply changes
rc-service postgresql restart

# Verify PostgreSQL is running
if rc-service postgresql status | grep -q "started"; then
    echo "PostgreSQL setup completed and running."
else
    echo "Failed to start PostgreSQL."
fi
