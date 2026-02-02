#!/bin/sh

# COULEURS
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

# Faire des tests avant pour voir si tout est correct

if [ ! -d "/var/lib/mysql/mysql"]; then
  echo -e "${YELLOW}Downloading MariaDB...${RESET}"
  mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

  echo -e "${YELLOW}Starting the server...${RESET}"
  mysqld_safe &
  sleep 5

  echo -e "${GREEN}MariaDB is on${RESET}"

  mysql -u root -e "FLUSH PRIVILEGES;"
  mysql -u root -e "CREATE DATABASE ${DB_NAME};"
  mysql -u root -e "CREATE USER IF NOT EXISTS 'ksilvest'@'%';"
fi

wait