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

# Pour faire des tests
exec-wp:
	docker exec -it srcs-wordpress-1 sh

# Pour faire des tests
exec-db:
	docker exec -it srcs-mariadb-1 sh

# Pas necessaire
logs-wp:
	docker logs -f srcs-wordpress-1

# Pas necessaire
logs-db:
	docker logs -f srcs-mariadb-1

.PHONY: all down stop re