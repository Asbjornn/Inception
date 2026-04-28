FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    wget curl php7.4-fpm php7.4-mysql mariadb-client && 
    rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
         -O /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY tools/init.sh /init.sh
RUN chmod +x /init.sh

RUN mkdir -p /var/www/wordpress

EXPOSE 9000

ENTRYPOINT ["/init.sh"]