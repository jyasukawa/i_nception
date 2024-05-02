include ./srcs/.env
# 環境変数を使うためにインクルード

all: up

up:
	@mkdir -p $(MARIADB_VOLUME_PATH)
	@mkdir -p $(WORDPRESS_VOLUME_PATH)
	@docker compose -f $(COMPOSE_YML_PATH) up -d --build
# 課題PDFより、Your volumes will be available in the /home/login/data folder of the host machine using Docker.

clean:
	@docker-compose -f $(COMPOSE_YML_PATH) down
# @-docker rmi -f `docker images -qa`
# -qオプションで取得するリストをidのみに限定して、それぞれを削除します。バッククォート ` は、バッククォート内のコマンドの結果を取得して使用することを意味します。$()も可。@-は、コマンド実行時にエラーが発生してもエラーを無視することを意味します。
	@-docker volume rm `docker volume ls -q`
# このvolumeはdocker system prune -af --volumesでも消せないため必要
	@rm -rf $(MARIADB_VOLUME_PATH)
	@rm -rf $(WORDPRESS_VOLUME_PATH)
	@docker system prune -af --volumes
# --all --force ボリュームも含めるオプション

.PHONY: all up clean
