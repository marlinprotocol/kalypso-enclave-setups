#!/bin/sh

# Install PostgreSQL and its client
apk add postgresql postgresql-client

# Define PostgreSQL data directory
PGDATA="/var/lib/postgresql/data"

# Ensure the PostgreSQL data directory is owned by the 'postgres' user
chown postgres:postgres /var/lib/postgresql

# Switch to the 'postgres' user and initialize the database cluster
su - postgres -c "initdb -D '$PGDATA'"

# Modify postgresql.conf to listen on all addresses
echo "listen_addresses='*'" >> "$PGDATA/postgresql.conf"

# Modify the pg_hba.conf file for md5 password authentication for IPv4 and IPv6
echo "host    all             all             0.0.0.0/0               md5" >> "$PGDATA/pg_hba.conf"
echo "host    all             all             ::/0                    md5" >> "$PGDATA/pg_hba.conf"

# Start PostgreSQL
rc-service postgresql start || { echo "Failed to start PostgreSQL"; exit 1; }
rc-update add postgresql default

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
