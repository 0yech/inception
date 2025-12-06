FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php \
    php-mysqli \
    wget \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/adminer

RUN wget https://www.adminer.org/latest.php -O /var/www/adminer/adminer.php
RUN echo "<?php require_once 'adminer.php';" > /var/www/adminer/index.php

WORKDIR /var/www/adminer

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/adminer"]
