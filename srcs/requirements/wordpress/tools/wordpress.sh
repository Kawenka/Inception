#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

MAX_RETRIES=10
COUNT=0

while ! mariadb-admin ping -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" --silent; do
    sleep 1
    echo -e "${YELLOW}Waiting...${RESET}"
    COUNT=$((COUNT+1))
    if [ $COUNT -eq $MAX_RETRIES ]; then
        echo -e "${RED}ERROR: MariaDB not available.${RESET}"
        exit 1
    fi
done

echo -e "${GREEN}Connected to the database${RESET}"


if [ ! -f wp-config.php ]; then
    echo -e "${YELLOW}Downloading Wordpress...${RESET}"
    php -d memory_limit=512M /usr/local/bin/wp core download

    echo -e "${YELLOW}Config creation...${RESET}"
    wp config create --dbname=$MYSQL_DATABASE \
                    --dbuser=$MYSQL_USER \
                    --dbhost=$DB_HOST \
                    --dbpass=$MYSQL_PASSWORD

    echo -e "${YELLOW}Finalizing installation...${RESET}"
    wp core install --url=$DOMAIN_NAME \
                    --title=$WP_TITLE \
                    --admin_user=$WP_ADMIN_USER \
                    --admin_password=$WP_ADMIN_PASSWORD \
                    --admin_email=$WP_ADMIN_EMAIL \
                    --skip-email 

    echo -e "${YELLOW}Creating a second user...${RESET}"
    wp user create $WP_USER $WP_USER_EMAIL \
                    --user_pass=$WP_PASSWORD \
                    --role=author 
fi

exec /usr/sbin/php-fpm83 -F