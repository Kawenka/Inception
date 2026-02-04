#!/bin/sh

# Se connecter a Mariadb
# Faire une boucle pour attendre la connexion

# Installer wp-cli si pas present avec wget
# Le rendre executable et le mettre dans le PATH

# Verifier si wp-config.php existe
# Sinon on lance la procedure (3 prochaines etapes)

echo "Mode TEST activé : J'attends..."

mariadb -h mariadb -u $MYSQL_USER -p$MYSQL_PASSWORD

tail -f /dev/null