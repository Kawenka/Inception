#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

# Verifier si wp-config.php existe
# Sinon on lance la procedure 
# Telecharger les fichiers sources de WordPress
# Configurer le lien avec la base de bonnees (wp-config.php)
# installer le liste (Creer les tables, le titre, l'admin)
# Creer l'utilisateur secondaire (demande par le sujet)

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

if [ ! -f /usr/local/bin/wp ]; then
    echo -e "${YELLOW}Downloading wp-cli${RESET}"
    wget --quiet https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

tail -f /dev/null