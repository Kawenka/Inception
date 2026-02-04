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

.PHONY: all down stop re