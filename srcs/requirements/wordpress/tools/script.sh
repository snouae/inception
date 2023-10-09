#!/bin/bash
sleep 1
mkdir -p /var/www/html
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
# if [ ! -f "/var/www/html/wp-config.php" ]; then
    wp core download --path=/var/www/html --allow-root 
    cd /var/www/html/
    wp config create --path=/var/www/html --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb --allow-root --skip-check
    # In other words, it tells WP-CLI to forcefully create a new wp-config.php file, even if one already exists in the target directory.
    # When you use the --allow-root flag, you're explicitly telling WP-CLI to bypass the restriction and allow the command to run as root. This can be necessary when working with system-level tasks or when managing WordPress installations that require elevated privileges. 
    wp core install --path=/var/www/html --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --allow-root
    # ommand is used to set up and configure a specific WordPress instance, including creating the initial database tables, configuring the basic site settings, and creating an initial administrator account.
    wp user create $WP_USER $WP_USER_EMAIL  --path=/var/www/html --role=author --user_pass=$WP_USER_PASS --allow-root
# fi

mkdir -p /run/php

# s typically used for storing PHP-FPM process information.
# PID Files log files , socket files data directories 

php-fpm7.4 -F

# php-fpm7.3 -F: Finally, this command starts PHP-FPM in the foreground (-F flag). It means PHP-FPM will run as the main process of the container and won't daemonize (run in the background). It remains active to handle PHP requests.