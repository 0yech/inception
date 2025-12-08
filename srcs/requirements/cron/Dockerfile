FROM debian:bullseye

RUN apt-get update -y && apt-get install -y \
    cron \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

COPY tools/backup.sh /usr/local/bin/backup.sh
COPY tools/crontab /etc/cron.d/db-backup

RUN chmod +x /usr/local/bin/backup.sh \
    && chmod 0644 /etc/cron.d/db-backup \
    && crontab /etc/cron.d/db-backup

CMD ["cron", "-f"]
