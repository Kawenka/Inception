all:
	@mkdir -p /home/ksilvest/data/mariadb
	@mkdir -p /home/ksilvest/data/wordpress
	docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker compose -f ./srcs/docker-compose.yml down

stop:
	docker compose -f ./srcs/docker-compose.yml stop

re:
	docker compose -f ./srcs/docker-compose.yml down
	docker compose -f ./srcs/docker-compose.yml up -d --build


fre:
	sudo rm -rf /home/ksilvest/data/mariadb/*
	sudo rm -rf /home/ksilvest/data/wordpress/*
	docker compose -f ./srcs/docker-compose.yml down
	docker compose -f ./srcs/docker-compose.yml up -d --build

# Pour faire des tests
exec-wp:
	docker exec -it wordpress sh

# Pour faire des tests
exec-db:
	docker exec -it mariadb sh

exec-ng:
	docker exec -it nginx sh

exec-ftp:
	docker exec -it ftp-server sh

# Pas necessaire
logs-wp:
	docker logs -f wordpress

# Pas necessaire
logs-db:
	docker logs -f mariadb

logs-ftp:
	docker logs -f ftp-server

logs-site:
	docker logs -f static-site

.PHONY: all down stop re fre
