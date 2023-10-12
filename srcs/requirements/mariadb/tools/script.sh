#!/bin/bash
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
service mariadb start
if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
    mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
    mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';"
    mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"
    mysql -e "alter user 'root'@'localhost' identified by '$DB_PASS';" 
fi
mysqladmin -u root -p"$DB_PASS" shutdown
mysqld_safe