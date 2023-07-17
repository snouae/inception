#!/bin/bash
# Create the database
DB_NAME="mydatabase"
DB_USER="myuser"
DB_PASS="mypassword"

service mysql start
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

mysql  -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# Create the user and grant privileges
mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';"
mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"
mysql -e "FLUSH PRIVILEGES;"
mysql -e "alter user 'root'@'localhost' identified by '$DB_PASS';" ;
mysql -e "FLUSH PRIVILEGES;"

# echo "MySQL database, user, and privileges have been set up successfully."

kill `cat /var/run/mysqld/mysqld.pid`
# service -u root -p${DB_PASS} mysql stop

#mysqladmin -u root -p"$DB_PASS" shutdown

exec "$@" 