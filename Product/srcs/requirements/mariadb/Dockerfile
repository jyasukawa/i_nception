FROM debian:bullseye

RUN apt update -y && \
	apt upgrade -y && \
	apt install -y mariadb-server

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/script.sh /

ENTRYPOINT ["/script.sh"]

CMD ["mysqld"]
