#!/bin/sh

# # Install PostgreSQL and its client
# apk add postgresql postgresql-client

# Define PostgreSQL data directory
PGDATA="/var/lib/postgresql/data"
mkdir -p $PGDATA
chown -R postgres:postgres /var/lib/postgresql

# Ensure the runtime directory exists and has correct permissions
mkdir -p /run/postgresql
chown -R postgres:postgres /run/postgresql
chmod 2777 /run/postgresql

# Initialize the database
su - postgres -c "initdb $PGDATA"

# Update postgresql.conf to listen on all interfaces
echo "listen_addresses='*'" >> "$PGDATA/postgresql.conf"

# Update pg_hba.conf for md5 authentication over IPv4 and IPv6
cat << EOF >> "$PGDATA/pg_hba.conf"
host    all             all             0.0.0.0/0               md5
host    all             all             ::/0                    md5
EOF

# Manually start PostgreSQL using pg_ctl
su - postgres -c "pg_ctl -D $PGDATA start"

# Sleep for a few seconds to ensure PostgreSQL starts up
sleep 5

# Create the user and database
su - postgres -c "psql -c \"CREATE USER postgres WITH ENCRYPTED PASSWORD 'postgres';\""
su - postgres -c "psql -c \"CREATE DATABASE postgres;\""
su - postgres -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE postgres TO postgres;\""

echo "PostgreSQL setup completed."
