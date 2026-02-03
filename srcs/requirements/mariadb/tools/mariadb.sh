#!/bin/sh

# COULEURS
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo -e "${YELLOW}Downloading MariaDB...${RESET}"
  mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null 2>&1

  echo -e "${YELLOW}Starting temporary server...${RESET}"
  /usr/bin/mysqld_safe --datadir=/var/lib/mysql > /dev/null 2>&1 &


  MAX_RETRIES=30
  COUNT=0
  until mariadb-admin ping > /dev/null 2>&1 || [ $COUNT -eq $MAX_RETRIES ]; do
    echo -ne "${YELLOW}Loading...${RESET}"
    sleep 1
    COUNT=$((COUNT + 1))
  done
  echo ""

  if [ $COUNT -eq $MAX_RETRIES ];then
    echo -e "${RED}ERROR: MariaDB failed to start within 30s.${RESET}"
    exit 1
  fi

  echo -e "${GREEN}MariaDB is on${RESET}"


  mariadb -u root << EOF > /dev/null 2>&1
  FLUSH PRIVILEGES;
  CREATE DATABASE IF NOT EXISTS ${DB_NAME};
  CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
  GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
  ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
  FLUSH PRIVILEGES;
EOF

  echo -e "${YELLOW}Stopping temporary server...${RESET}"
  mariadb-admin -u root -p"${DB_ROOT_PASSWORD}" shutdown > /dev/null 2>&1

  echo -e "${GREEN}MariaDB setup done!${RESET}"
fi

echo -e "${GREEN}Starting MariaDB final server...${RESET}"
exec mysqld_safe --datadir=/var/lib/mysql > /dev/null 2>&1