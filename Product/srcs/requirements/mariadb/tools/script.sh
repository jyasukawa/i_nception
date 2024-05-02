#!/bin/bash

service mariadb start > /dev/null 2>&1

sleep 5

echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';" > tmp.txt
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE_NAME;" >> tmp.txt
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE_NAME.* TO '$MYSQL_USER'@'%';" >> tmp.txt
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> tmp.txt
echo "FLUSH PRIVILEGES;" >> tmp.txt

mysql < tmp.txt

rm tmp.txt

mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

exec "$@"
