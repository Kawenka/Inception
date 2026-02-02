# --- VARIABLES ---
NAME        = mariadb
IMG_NAME    = mariadb:inception
# Dossier où se trouve le Dockerfile (point actuel)
BUILD_PATH  = .

# --- REGLES ---

# Par défaut, on construit et on lance
all: build run

# 1. Construction de l'image
build:
	docker build -t $(IMG_NAME) $(BUILD_PATH)

# 2. Lancement du conteneur
# J'ai mis toute la commande sur une seule ligne pour éviter les bugs de backslash \
# C'est moins joli mais beaucoup plus fiable pour commencer.
run:
	@echo "🚀 Lancement du conteneur $(NAME)..."
	# On remplace toutes les lignes -e PAR --env-file
	docker run -d --name $(NAME) \
	--env-file ../../.env \
	$(IMG_NAME)
	@echo "✅ Conteneur lancé !"

# 3. Entrer dans le conteneur (Debug)
exec:
	docker exec -it $(NAME) sh

# 4. Voir les logs
logs:
	docker logs $(NAME)

# 5. Nettoyage (Le '-' devant docker permet d'ignorer l'erreur si le conteneur n'existe pas)
clean:
	@echo "🧹 Nettoyage..."
	-docker stop $(NAME)
	-docker rm $(NAME)

# 6. Re: Nettoyer, Reconstruire, Relancer
re: clean build run

.PHONY: all build run exec logs clean re