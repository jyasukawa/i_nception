FROM debian:bullseye

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install wget -y && \
    apt-get install php-fpm php-mysql mariadb-client -y

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    mkdir -p /var/www/html

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/script.sh /
RUN chmod +x /script.sh

WORKDIR /var/www/html
# mkdir -p /var/www/html && WORKDIR /var/www/html してパスを一つに指定してあげないと、重複エラーになる危険

ENTRYPOINT ["/script.sh"]

CMD ["php-fpm7.4", "-F"]
