

#!/bin/bash
sleep 5
mkdir -p /var/www
mkdir -p /var/www/html

DB_NAME="mydatabase"
DB_USER="myuser"
DB_PASS="mypassword"
WP_URL="localhost"
WP_TITLE="wp"
WP_ADMIN_USER="admin"
WP_ADMIN_PASS="123"
WP_ADMIN_EMAIL="email@gmail.com"

WP_USER="wpu"
WP_USER_EMAIL="emailu@gmail.com"
WP_USER_PASS="1234"
HOST="mariadb"

#echo "<?php phpinfo(); ?>" > /var/www/html/index.php
# uses the sed command to modify the www.conf file in the /etc/php/7.3/fpm/pool.d directory. The s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g 
# command substitutes the value 9000 for /run/php/php7.3-fpm.sock throughout the file. This changes the socket that PHP-FPM listens on from a Unix domain socket to a TCP port.
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

# downloads the WP-CLI PHAR (PHP Archive) file from the GitHub repository. The -O flag tells curl to save the file with the same name as it has on the server.
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# makes the WP-CLI PHAR file executable.
chmod +x wp-cli.phar

# moves the WP-CLI PHAR file to the /usr/local/bin directory, which is in the system's PATH, and renames it to wp. This allows you to run the wp command from any directory
mv wp-cli.phar /usr/local/bin/wp
# downloads the latest version of WordPress to the current directory. The --allow-root flag allows the command to be run as the root user, which is necessary if you are logged 0in as the root user or if you are using WP-CLI with a system-level installation of WordPress.
wp core download --path=/var/www/html --allow-root 
cd /var/www/html/
# cp wp-config-sample.php wp-config.php
# sed -i "s/database_name_here/$DB_NAME/g" "/var/www/html/wp-config.php"
# sed -i "s/username_here/$DB_USER/g" "/var/www/html/wp-config.php"
# sed -i "s/password_here/$DB_PASS/g" "/var/www/html/wp-config.php"
# sed -i "s/localhost/$HOST/g" "/var/www/html/wp-config.php"

wp config create --path=/var/www/html --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb --allow-root --skip-check

# installs WordPress and sets up the basic configuration for the site. The --url option specifies the URL of the site, --title sets the site's title, --admin_user and --admin_password set the username and password for the site's administrator account, and --admin_email sets the email address for the administrator. The --skip-email flag prevents WP-CLI from sending an email to the administrator with the login details.
wp core install --path=/var/www/html --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --allow-root

# creates a new user account with the specified username, email address, and password. The --role option sets the user's role to author, which gives the user the ability to publish and manage their own posts.
wp user create $WP_USER $WP_USER_EMAIL  --path=/var/www/html --role=author --user_pass=$WP_USER_PASS --allow-root

# creates the /run/php directory, which is used by PHP-FPM to store Unix domain sockets.
mkdir /run/php
# starts the PHP-FPM service in the foreground. The -F flag tells PHP-FPM to run in the foreground, rather than as a daemon in the background.
/usr/sbin/php-fpm7.3 -F
#php7.3-fpm --nodaemonize
#tail -f /dev/random