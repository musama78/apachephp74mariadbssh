#!/bin/bash

cd /root/mydocker/
# Check if mariaDB-Container is running
if ! docker ps | grep mariaDB-Container; then
  # If not running, run it using the specified compose file
  docker-compose -f docker-compose.mariadb.yml up -d
fi

