NAME = wordpress
WP_NAME = wordpress:inception
BUILD_PATH = .

all: build run

build: 
	docker build -t $(WP_NAME) $(BUILD_PATH)
run: 
	docker run -d --rm --name $(NAME) $(WP_NAME)

exec:
	docker exec -it $(NAME) sh

logs:
	docker logs $(NAME)

clean:
	-docker stop $(NAME)
	-docker rm -f $(NAME)

re: clean build run

.PHONY: build run all clean re exec logs