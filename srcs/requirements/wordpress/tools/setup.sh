#!/bin/bash
set -e

# WordPress path
WP_PATH="/var/www/wordpress"

echo "Waiting for MariaDB..."
sleep 10

# Copy the sample config file if it doesn't exist
if [ ! -f "$WP_PATH/wp-config.php" ]; then
    cp $WP_PATH/wp-config-sample.php $WP_PATH/wp-config.php
fi

# Replace database configuration variables
sed -i "s/database_name_here/${MYSQL_DATABASE}/" $WP_PATH/wp-config.php
sed -i "s/username_here/${MYSQL_USER}/" $WP_PATH/wp-config.php
sed -i "s/password_here/${MYSQL_PASSWORD}/" $WP_PATH/wp-config.php
sed -i "s/localhost/mariadb/" $WP_PATH/wp-config.php

# Fix file permissions
chown -R www-data:www-data $WP_PATH

# Prepare PHP-FPM directory
mkdir -p /run/php

# Launch PHP-FPM in foreground mode
echo "Starting PHP-FPM..."
exec php-fpm7.4 -F

