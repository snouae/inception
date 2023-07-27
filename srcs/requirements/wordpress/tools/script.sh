
#!/bin/bash
sleep 5
mkdir -p /var/www
mkdir -p /var/www/html
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
wp core download --path=/var/www/html --allow-root 
cd /var/www/html/
wp config create --path=/var/www/html --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb:3306 --allow-root --skip-check
wp core install --path=/var/www/html --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --allow-root
wp user create $WP_USER $WP_USER_EMAIL  --path=/var/www/html --role=author --user_pass=$WP_USER_PASS --allow-root
mkdir /run/php
/usr/sbin/php-fpm7.3 -F