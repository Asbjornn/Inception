#!/bin/bash

set -e

# Lire les secrets Docker (montés dans /run/secrets/)
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

if [ ! -d /var/lib/mysql/mysql ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

    # démarre mariaDB temporairement pour la configurer
    until mysqld_safe --skip-networking; do & 
        sleep 1
    done

    mysql -u root <<-EOF
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
        CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
        GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
        FLUSH PRIVILEGES;
EOF

    # arrete mariaDB temporaire
    mysqladmin u root -p"${DB_ROOT_PASSWORD}" shutdown
fi

exec mysqld_safe