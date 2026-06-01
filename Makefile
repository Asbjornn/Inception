COMPOSE = srcs/docker-compose.yml

all: build

build:
	docker compose -f $(COMPOSE) build

up:
	docker compose -f $(COMPOSE) up -d

down:
	docker compose -f $(COMPOSE) down

volume:
	sudo rm -rf /home/gcauchy/data/mariadb/.initialized
	sudo rm -rf /home/gcauchy/data/mariadb/*
	sudo rm -rf /home/gcauchy/data/wordpress/*

clean: down
	docker compose -f $(COMPOSE) down -v

fclean: clean
	docker system prune -af

re: fclean build up

.PHONY: all build up down volume clean fclean re
