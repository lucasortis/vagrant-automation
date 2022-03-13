#!/bin/bash
cat /configs/bionic-key.pub >> .ssh/authorized_keys
apt-get update && \
apt-get install -y mysql-server-5.7 && \
mysql -e "create user 'phpuser'@'%' identified by 'pass';"
cat /configs/mysqld.cnf > /etc/mysql/mysql.conf.d/mysqld.cnf
service mysql restart