#!/bin/sh

# # Install Nginx
# apk update
# apk add nginx

# Create the directory for Nginx PID and run files if it doesn't exist
mkdir -p /run/nginx

# Prepare Nginx configuration for reverse proxy
CONFIG="/etc/nginx/http.d/default.conf"
echo "server {
    listen 8545;

    location / {
        proxy_pass http://46.4.77.113:8545;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}" > $CONFIG

# Starting Nginx
nginx -t && nginx

# Sleep for a few seconds to ensure Nginx starts up
sleep 5

echo "NGINX setup completed."

# # Make sure Nginx starts on boot
# rc-update add nginx default
