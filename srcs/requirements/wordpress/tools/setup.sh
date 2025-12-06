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

# Redis config
if ! grep -q "WP_REDIS_HOST" "$WP_PATH/wp-config.php"; then
    sed -i "/define( 'WP_DEBUG'/i \
define('WP_REDIS_HOST', 'redis');\n\
define('WP_REDIS_PORT', 6379);\n\
define('WP_CACHE', true);\n\
define('WP_CACHE_KEY_SALT', 'inception_42_');\n" \
    $WP_PATH/wp-config.php
fi

# Fix file permissions
chown -R www-data:www-data $WP_PATH

# Install Redis plugin if not installed
if ! wp plugin is-installed redis-cache --path=$WP_PATH --allow-root; then
    wp plugin install redis-cache --activate --path=$WP_PATH --allow-root
fi

# Enable Redis cache
if ! wp redis status --path=$WP_PATH --allow-root | grep -q "Connected"; then
    wp redis enable --path=$WP_PATH --allow-root
fi

# Prepare PHP-FPM directory
mkdir -p /run/php

# Launch PHP-FPM in foreground mode
echo "Starting PHP-FPM..."
exec php-fpm7.4 -F

