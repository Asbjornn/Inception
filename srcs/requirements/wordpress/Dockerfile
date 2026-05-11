FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    wget curl \
    php8.2-fpm php8.2-mysql php8.2-curl \
    php8.2-gd php8.2-xml php8.2-mbstring \
    mariadb-client && \
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