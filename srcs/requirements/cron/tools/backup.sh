#!/bin/bash
set -e

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="/backup"
FILENAME="wordpress_db_$TIMESTAMP.sql"

echo "DB backup: $FILENAME"

mysqldump \
    -h mariadb \
    -u "$MYSQL_USER" \
    -p"$MYSQL_PASSWORD" \
    "$MYSQL_DATABASE" \
    > "$BACKUP_DIR/$FILENAME"

echo "Backup done (mysqldump cron)"
