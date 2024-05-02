#!/bin/bash

service mariadb start > /dev/null 2>&1 # > /dev/null 2>&1 logsに出なくなる
# mariadbサービスを開始します。これにより、mariadbサーバーが実行され、クエリの実行やデータベースの操作が可能になる

sleep 5
# これがないとサーバーが死ぬ時がある

echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';" > tmp.txt
# ＞にすることで、tmp.txtがすでにある場合は上書き、ない場合は作成。| mysql とする方法もある
# 新しいユーザーを作成する。'@'%' はどのホストからの接続でも許可することを示す。IDENTIFIED BYによってパスワードを設定する。これは新しいユーザーの作成に一回だけ行えば良い。
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE_NAME;" >> tmp.txt
# データベースを作成
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE_NAME.* TO '$MYSQL_USER'@'%';" >> tmp.txt
# 特定のデータベースに対して特定のユーザーに全ての権限を付与する
# echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> tmp.txt
# もし万が一rootがなければrootに全てのDBの権限を付与かつ、デフォルトのrootにパスワードを設定.多分なくてもいい
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> tmp.txt
# デフォルトのrootにパスワードを設定,これがないとrootはパスワードなしでログインできてしまう
echo "FLUSH PRIVILEGES;" >> tmp.txt
# 特定の権限設定の変更を適用する

mysql < tmp.txt
# tmp.txtに書き込んだコマンドをまとめて実行する

rm tmp.txt

service mariadb stop > /dev/null 2>&1
# mariadbサービスを停止
# mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown 正式なシャットダウン要求
# こっちのほうが不安定にならなくていいかも
# kill $(cat /var/run/mysqld/mysqld.pid) 強制的にプロセスを停止

exec "$@"
# exec "$@" は、スクリプトに渡された引数をそのまま実行するためのコマンド
# ENTRYPOINT、CMDこの2つを組み合わせると、CMDの値がENTRYPOINTのデフォルトの引数として機能し、イメージの動作をカスタマイズ可能
# 通常はmysqldが実行される