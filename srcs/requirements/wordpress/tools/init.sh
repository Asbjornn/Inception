#!/bin/sh

set -e

DB_PASSWORD=$(cat /run/secrets/db_password)
ADMIN_PASSWORD=$(cat /run/secrets/credentials | grep ADMIN_PASS | cut -d= -f2)
USER_PASSWORD=$(cat /run/secrets/credentials | grep USER_PASS | cut -d= -f2)

WP_DIR=/var/www/html

# Télécharger WordPress s'il n'est pas déjà là
if [ ! -f ${WP_DIR}/wp-config.php ] || ! wp core is-installed --path=${WP_DIR} --allow-root 2>/dev/null; then

    # Télécharger WordPress
    wp core download --path=${WP_DIR} --allow-root

    # Créer wp-config.php avec les infos de la BDD
    wp config create \
        --path=${WP_DIR} \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${DB_PASSWORD} \
        --dbhost=mariadb \
        --allow-root

    # Attendre que MariaDB soit prêt
    while ! wp db check --path=${WP_DIR} --allow-root 2>/dev/null; do
        echo 'En attente de MariaDB...'
        sleep 2 
    done


    # Installer WordPress (crée les tables en BDD)
    wp core install \
        --path=${WP_DIR} \
        --url=https://${DOMAIN_NAME} \
        --title='Mon Site' \
        --admin_user=${ADMIN_USER} \
        --admin_password=${ADMIN_PASSWORD} \
        --admin_email=${ADMIN_EMAIL} \
        --allow-root

    # Créer un 2e utilisateur (exigé par le sujet)
    wp user create ${WP_USER} ${WP_USER_EMAIL} \
        --role=author \
        --user_pass=${USER_PASSWORD} \
        --path=${WP_DIR} \
        --allow-root

    # Corriger les permissions
    chown -R www-data:www-data ${WP_DIR}
fi

# Lancer PHP-FPM en foreground
exec php-fpm8.2 -F