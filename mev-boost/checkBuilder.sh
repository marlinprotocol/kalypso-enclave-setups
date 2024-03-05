#!/bin/sh

URL="curl http://localhost:9062/eth/v1/builder/status"

# Infinite loop to run curl every 10 seconds
while true; do
  curl $URL
  echo "Sleeping for 10 seconds..."
  sleep 10
done
