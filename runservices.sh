#!/bin/bash

#run ssh
/usr/sbin/sshd

service apache2 start

chown -R mysql:mysql /var/lib/mysql
/usr/sbin/mysqld --user=mysql --basedir=/usr

service mariadb start
# Keep the container running
while true; do
  sleep 1000;
done;


