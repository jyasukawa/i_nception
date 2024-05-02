include ./srcs/.env

all: up

up:
	@mkdir -p $(MARIADB_VOLUME_PATH)
	@mkdir -p $(WORDPRESS_VOLUME_PATH)
	@docker compose -f $(COMPOSE_YML_PATH) up -d --build

clean:
	@docker-compose -f $(COMPOSE_YML_PATH) down
	@-docker volume rm `docker volume ls -q`
	@rm -rf $(MARIADB_VOLUME_PATH)
	@rm -rf $(WORDPRESS_VOLUME_PATH)
	@docker system prune -af --volumes

.PHONY: all up clean
