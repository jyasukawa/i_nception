FROM debian:bullseye

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install wget -y && \
    apt-get install php-fpm php-mysql mariadb-client -y

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html
    #コンテナ内のvar/www以下の権限がgit cloneしてきたrootのものになっているので、nginxのユーザーであるwww-dataにコマンドで変更しておく

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
# docker container exec wordpress_container ls /etc/php -> 7.4

COPY ./tools/script.sh /
RUN chmod +x /script.sh

WORKDIR /var/www/html

ENTRYPOINT ["/script.sh"]

CMD ["php-fpm7.4", "-F"]
