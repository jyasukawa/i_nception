#!/bin/bash

sleep 10

if [ ! -f "/var/www/html/wp-config.php" ]; then
    wp core download --path=/var/www/html --allow-root --quiet;
    wp config create --dbname="$MYSQL_DATABASE_NAME" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_USER_PASSWORD" --dbhost=mariadb:3306 --path=/var/www/html --allow-root --quiet;
    wp core install --url="$DOMAIN_NAME" --title="wordpress" --admin_user="$WP_ADMIN" --admin_password="$WP_ADMINPASS" --admin_email="$WP_ADMINMAIL" --skip-email --path=/var/www/html --allow-root --quiet;
    wp user create "$WP_USER" "$WP_USERMAIL" --user_pass="$WP_USERPASS" --path=/var/www/html --allow-root --quiet;
fi

chmod 777 /var/www/html/wp-content
mkdir -p /run/php/

exec "$@"



# #!/bin/bash

# sleep 10

# if [ ! -f "/var/www/html/wp-config.php" ]; then
#     wp core download --path=/var/www/html --allow-root --quiet;
#     wp config create --dbname=$MYSQL_DATABASE_NAME --dbuser=$MYSQL_USER --dbpass=$MYSQL_USER_PASSWORD --dbhost=$MYSQL_HOST --path=/var/www/html --allow-root --quiet;
#     wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMINPASS --admin_email=$WP_ADMINMAIL --skip-email --path=/var/www/html --allow-root --quiet;
#     wp user create $WP_USER $WP_USERMAIL --user_pass=$WP_USERPASS --role=author --path=/var/www/html --allow-root --quiet;
# fi

# chmod 777 /var/www/html/wp-content

# mkdir -p /run/php/

# exec "$@"
