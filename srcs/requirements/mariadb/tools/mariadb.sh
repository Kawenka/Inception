#!/bin/sh

# COULEURS
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

# Faire des tests avant pour voir si tout est correct

if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo -e "${YELLOW}Downloading MariaDB...${RESET}"
  mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

  echo -e "${YELLOW}Starting the server...${RESET}"
  /usr/bin/mysqld_safe --datadir=/var/lib/mysql &

  echo -e "${YELLOW}Waiting for server startup...${RESET}"
  sleep 5

  echo -e "${GREEN}MariaDB is on${RESET}"

  mysql -u root -e "FLUSH PRIVILEGES;"
  mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
  mysql -u root -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
  mysql -u root -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
  mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}'"
  mysql -u root -e "FLUSH PRIVILEGES;"

  echo -e "${YELLOW}Stopping temporary server...${RESET}"
  mysqladmin -u root -p"${DB_ROOT_PASSWORD}" shutdown
fi

exec mysqld_safe --datadir=/var/lib/mysql