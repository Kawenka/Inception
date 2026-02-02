# Variables
NAME = mariadb
IMG_NAME = mariadb:inception

# Commandes
all: build run

# Construit l'image
build:
	docker build -t $(IMG_NAME) .

# Lance le conteneur (avec toutes tes variables)
run:
    @echo "Lancement du conteneur..."
    docker run -d --name $(NAME) \
    -e DB_NAME=inception \
    -e DB_USER=ksilvest \
    -e DB_PASSWORD=password \
    -e DB_ROOT_PASSWORD=rootpassword \
    $(IMG_NAME)
    @echo "Conteneur lancé ! Tape 'make logs' pour voir ce qui se passe."

# Entre dans le conteneur (pour tester manuellement)
exec:
	docker exec -it $(NAME) sh

# Affiche les logs
logs:
	docker logs $(NAME)

# Nettoie le conteneur (Stop + Remove)
clean:
	@echo "Nettoyage..."
	-docker stop $(NAME)
	-docker rm $(NAME)

# La commande magique : Nettoie, Reconstruit et Relance
re: clean build run