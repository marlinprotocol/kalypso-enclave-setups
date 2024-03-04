#!/bin/sh

# Initialize the database
postgresql-setup initdb

# Modify the pg_hba.conf file for md5 password authentication
PG_HBA_CONF_PATH="/var/lib/postgresql/data/pg_hba.conf"
sed -i "s|host    all             all             127.0.0.1/32            ident|host    all             all             127.0.0.1/32            md5|" "$PG_HBA_CONF_PATH"
sed -i "s|host    all             all             ::1/128                 ident|host    all             all             ::1/128                 md5|" "$PG_HBA_CONF_PATH"

# Start the PostgreSQL service
rc-service postgresql start
# Enable PostgreSQL to start on boot
rc-update add postgresql default

# Create a user and a database
su - postgres -c "psql -c \"CREATE USER postgres WITH ENCRYPTED PASSWORD 'postgres';\""
su - postgres -c "psql -c \"CREATE DATABASE postgres;\""
su - postgres -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE postgres TO postgres;\""

# Restart PostgreSQL to apply changes
rc-service postgresql restart

echo "PostgreSQL setup completed."
