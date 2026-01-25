FROM debian:bookworm
RUN apt update && apt install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    mariadb-client \
    curl \

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

RUN curl -O https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
    && rm latest.tar.gz \ 
    && chown -R www-data:www-data /var/www/html

COPY conf/ww-config.php var/www/html/wordpress/wp-config.php

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]