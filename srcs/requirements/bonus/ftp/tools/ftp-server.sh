#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

if ! id "$FTP_USER" > /dev/null 2>&1; then
    echo -e "${YELLOW}Création de l'utilisateur FTP: $FTP_USER${RESET}"
    
    adduser -h /var/www/html -D "$FTP_USER"
    
    echo "$FTP_USER:$FTP_PASS" | chpasswd
    
    chown -R "$FTP_USER:$FTP_USER" /var/www/html
fi

echo -e "${GREEN}Démarrage du serveur FTP...${RESET}"

exec "$@"
