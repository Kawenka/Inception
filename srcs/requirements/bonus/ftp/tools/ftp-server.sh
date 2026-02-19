#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

if ! id "$FTP_USER" > /dev/null 2>&1; then
    echo -e "${YELLOW}Création de l'utilisateur FTP: $FTP_USER${RESET}"
    
    # -h /var/www/html : On force son dossier personnel à être celui de WordPress
    # -s /sbin/nologin : Sécurité, on lui interdit d'ouvrir un vrai terminal
    # -D : Ne demande pas de mot de passe
    adduser -h /var/www/html -D "$FTP_USER"
    
    # On lui attribue le mot de passe défini dans le .env
    echo "$FTP_USER:$FTP_PASS" | chpasswd
    
    chown -R "$FTP_USER:$FTP_USER" /var/www/html
fi

echo "${GREEN}Démarrage du serveur FTP...${RESET}"

# La commande 'exec "$@" récupère la ligne CMD du Dockerfile 
# ("/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf")
# et remplace le script bash par vsftpd. C'est lui qui gardera le conteneur en vie
exec "$@"
