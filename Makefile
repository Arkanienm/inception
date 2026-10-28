SRCS_DIR	= ./srcs
DOCKER_COMPOSE	= docker compose -f $(SRCS_DIR)/docker-compose.yml
DATA_DIR	= /home/amurtas/data

GREEN		= \033[0;32m
YELLOW		= \033[0;33m
RED		= \033[0;31m
RESET		= \033[0m

all: up

up: create_dirs
	@echo "$(GREEN)Démarrage des conteneurs Inception...$(RESET)"
	@$(DOCKER_COMPOSE) up -d --build

create_dirs:
	@mkdir -p $(DATA_DIR)/wordpress
	@mkdir -p $(DATA_DIR)/mariadb

down:
	@echo "$(YELLOW)Arrêt des conteneurs...$(RESET)"
	@$(DOCKER_COMPOSE) down

clean:
	@echo "$(RED)Nettoyage des conteneurs et réseaux...$(RESET)"
	@$(DOCKER_COMPOSE) down -v

fclean: clean
	@echo "$(RED)Suppression des données locales sur l'hôte...$(RESET)"
	@sudo rm -rf $(DATA_DIR)/wordpress/*
	@sudo rm -rf $(DATA_DIR)/mariadb/*
	@docker system prune -a --force

re: fclean all

.PHONY: all up create_dirs down clean fclean re