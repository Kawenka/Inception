#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

# Installer wp-cli si pas present avec wget
# Le rendre executable et le mettre dans le PATH

# Verifier si wp-config.php existe
# Sinon on lance la procedure (3 prochaines etapes)

MAX_RETRIES=10
COUNT=0

while ! mariadb-admin ping -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" --silent; do
    sleep 1
    echo "Waiting..."
    COUNT=$((COUNT+1))
    if [ $COUNT -eq $MAX_RETRIES ]; then
        echo "ERROR: MariaDB not available."
        exit 1
    fi
done

echo -e "${GREEN}Connected to the database${RESET}"

if [ ! -f /usr/local/bin/wp ]; then
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

tail -f /dev/null