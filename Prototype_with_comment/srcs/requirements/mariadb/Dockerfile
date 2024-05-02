FROM debian:bullseye
# Alpine/Debian以外のimageを使用することは禁止されているため、まず、ベースイメージとなるAlpine/Debianを入れる
# FROM 命令を追記すると「これから debian:bullseye のレイヤーの上にさらにレイヤーを乗せていくぞ」という意味になる

RUN apt update -y && \
	apt upgrade -y && \
	apt install -y mariadb-server
# apt-getは古くから存在するaptのコマンドで、Debianやその派生ディストリビューションで広く使用されている
# aptコマンドはapt-getの機能を包含している最新バージョン
# updateコマンドで最新のパッケージリストを取得、upgradeコマンドでそれらのパッケージを実際にアップグレードする
# -yオプションは、パッケージをインストールする際に確認プロンプトを表示せず、自動的に"Yes"と承認されたものとして処理する
# MariaDBはMySQLから派生したデータベースでありスペックや機能面でもmariaDBの方が優れている
# インストールしただけではセキュリティ面で安全ではないため、セキュリティスクリプトを実行する必要がある
# RUNを複数行で書くか、&&を使うかは容量や変更->再ビルドをするかどうかによって使い分ける
# mariadb-client をインストールすると、MySQL/MariaDBサーバーに接続するためのクライアントツールが含まれます。これには、mysql コマンドやGUIベースのクライアントが含まれています。通常はサーバーと同じ環境にクライアントをインストールすることが推奨されます

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
# 設定ファイルを編集することでMariaDBを自分の環境やニーズに最適化し、セキュリティを強化し、パフォーマンスを向上させる
# 今回はbind-address = 0.0.0.0にすることが必須
# MariaDBのサーバーの設定ファイルは /etc/mysql/mariadb.conf.d/50-server.cnf
# ローカルの./conf/50-server.cnfをdockerコンテナの/etc/mysql/mariadb.conf.d/にある50-server.cnfを上書き

COPY ./tools/script.sh /
# MySQLのセットアップやデータベースの作成を自動化するスクリプトをローカルからコピーする
# RUN  chmod +x /script.sh
# スクリプトの実行権限を付与する

ENTRYPOINT ["/script.sh"]
CMD ["mysqld"]
# スクリプトを実行する。今回はあえてENTRYPOINTは使わない。
# ENTRYPOINT: コンテナが起動された際に必ず実行されるコマンドやスクリプトを指定します。通常、ENTRYPOINT はコンテナの起動時に必要な初期化やサービスの開始などを行うために使用されます
# CMD: コンテナが起動された際にデフォルトで実行されるコマンドやスクリプトを指定します。ただし、コンテナを実行する際にコマンドを指定した場合は、その指定されたコマンドが優先されます
# 一般的には、ENTRYPOINT はコンテナの初期化やサービスの開始などに使用し、CMD はコンテナのデフォルト動作を設定する際に使用します
