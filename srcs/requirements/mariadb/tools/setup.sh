#!/bin/bash
set -e

chown -R mysql:mysql /var/lib/mysql

DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

if [ ! -f /var/lib/mysql/.initialized ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

    mysqld --user=mysql --skip-networking &
    until mysqladmin ping --silent; do sleep 1; done

    mysql -u root <<-EOF
	ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
	CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
	CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
	GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
	FLUSH PRIVILEGES;
EOF

    mysqladmin -u root -p"${DB_ROOT_PASSWORD}" shutdown
    touch /var/lib/mysql/.initialized
    echo "Database initialized."
fi

echo "Starting MariaDB (normal mode)..."
exec mysqld --user=mysql


salut je suis gabin cauchy et j'ecris avec 4 doigts sur chaque mains