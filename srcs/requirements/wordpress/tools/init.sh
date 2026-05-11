#!/bin/sh

set -e

DB_PASSWORD=$(cat /run/secrets/db_password)
ADMIN_PASSWORD=$(cat /run/secrets/credentials | grep ADMIN_PASS | cut -d= -f2)
USER_PASSWORD=$(cat /run/secrets/credentials | grep USER_PASS | cut -d= -f2)

WP_DIR=/var/www/html

mkdir -p ${WP_DIR}

if [ ! -f ${WP_DIR}/index.php ]; then
    echo "Downloading WordPress..."
    wp core download --path=${WP_DIR} --allow-root
fi

if [ ! -f ${WP_DIR}/wp-config.php ]; then
    echo "Creating wp-config.php..."
    wp config create \
        --path=${WP_DIR} \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${DB_PASSWORD} \
        --dbhost=mariadb \
        --allow-root
fi

while ! wp db check --path=${WP_DIR} --allow-root 2>/dev/null; do
    echo 'En attente de MariaDB...'
    sleep 2 
done

if ! wp core is-installed --path=${WP_DIR} --allow-root 2>/dev/null; then
    echo "Installing WordPress..."

    wp core install \
        --path=${WP_DIR} \
        --url=https://${DOMAIN_NAME} \
        --title='Mon Site' \
        --admin_user=${ADMIN_USER} \
        --admin_password=${ADMIN_PASSWORD} \
        --admin_email=${ADMIN_EMAIL} \
        --allow-root

    wp user create ${WP_USER} ${WP_USER_EMAIL} \
        --role=author \
        --user_pass=${USER_PASSWORD} \
        --path=${WP_DIR} \
        --allow-root
fi

chown -R www-data:www-data ${WP_DIR}

# Lancer PHP-FPM en foreground
exec php-fpm8.2 -F