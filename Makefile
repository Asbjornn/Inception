LOGIN = gcauchy
COMPOSE = srcs/docker-compose.yml

all:
	docker-compose -f $(COMPOSE) up --build -d

down:
	docker-compose -f $(COMPOSE) down

clean: down
	docker-compose -f $(COMPOSE) down -v

fclean: clean
	docker system prune -af

re: fclean all

.PHONY: all down clean fclean re