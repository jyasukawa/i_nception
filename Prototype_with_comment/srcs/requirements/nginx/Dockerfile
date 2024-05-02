FROM debian:bullseye

RUN apt update -y && \
	apt upgrade -y && \
	apt install nginx openssl -y

RUN mkdir /etc/nginx/ssl
# SSLの自己証明書を使いHTTPS通信ができるようにします。
# SSL証明書などのセキュリティ関連のファイルを配置するために、Nginxの設定ファイルを格納するディレクトリを作成する
# NginxのSSL（Secure Sockets Layer）は、WebサーバーNginxがHTTPSプロトコルを使用してセキュアな通信を行うための機能です。SSLは、Webサイトやアプリケーションとユーザーの間でデータを暗号化し、プライバシーとセキュリティを強化するために使用されます。

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
# -nodesを使用しない場合は、秘密鍵にアクセスするためにパスワードが必要になります。一方で、-nodesを指定すると、パスワードの入力を省略して秘密鍵を生成できます
# -sha256を指定しないと、証明書のハッシュにSHA-1が使用される可能性があり、セキュリティ上のリスクが高まる可能性があります。
	-out /etc/nginx/ssl/inception.crt \
	# 生成された証明書を保存するファイルのパス
	-keyout /etc/nginx/ssl/inception.key \
	# 生成された秘密鍵を保存するファイルのパス
	-subj "/C=JP/ST=Tokyo/L=Tokyo/O=42tokyo/OU=42cursus/CN=jyasukaw.42.fr"
	# OpenSSLコマンドにおいて証明書に関する情報を指定するためのオプション
# OpenSSLツールを使用してSSL証明書と秘密鍵を生成する
# OpenSSLには他に文章の暗号化など、様々な機能がある

# RUN openssl req \
# 	-newkey rsa:4096 \
# 	-x509 \
# 	-sha256 \
# 	-days 365 \
# 	# -は全てオプション
# 	-nodes \
# 	-out $CERT_PATH \
# 	-keyout $PRIVKEY_PATH \
# 	-subj "/C=JP/ST=Tokyo/L=Tokyo/O=42tokyo/OU=42cursus/CN=jyasukaw.42.fr"
# dockerfile内で環境変数をつかうにはENVを使わないといけないため、.shを使うことになりそう

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
# conf.d/default.conf->nginxインストール時のデフォルトのserverの設定ファイル.nginx.confのバーチャルホスト宣言(server定義)を外だしにして、バーチャルホスト別に管理し易くした設定ファイルです。
# nginx.confには、Nginx の基本的な設定が記述されており、default.confを読み込む設定がされています。default.conf には、デフォルトで動作する Web サーバーの設定などが記述されていますが、PHP-FPM に接続するための設定がなされていません。そこで、独自の default.conf を作成します。

RUN mkdir -p /run/nginx
# nginxをスタートさせるためのディレクトリをつくる
# -p オプションは、親ディレクトリも必要に応じて作成する。つまり/run ディレクトリも。
# Nginxの場合は /run/nginx ディレクトリが存在することが期待されることがある

EXPOSE 443
# Dockerコンテナがリスニングするポートを設定するためのものです。具体的には、この命令はDockerコンテナがポート443をリスニングすることを示します。Dockerコンテナが外部からアクセス可能にするポートを指定します。ただし、この命令自体はポートをオープンするわけではなく、単にポートの公開を示すだけです。実際にポートを公開するには、docker run コマンドで -p オプションを使用する必要があります。ポート443は一般的にHTTPSのデフォルトポートとして知られており、SSL/TLS通信のために使用されます。したがって、この命令を使用してポート443を公開することは、Dockerコンテナ内でHTTPSサーバーを実行する場合に便利です。ただし、実際にポートを公開するには、docker run コマンドで適切な設定を行う必要があります。

CMD ["nginx", "-g", "daemon off;"]
# "-g": Nginxに後で指定したグローバルな設定を行う
# Nginxをデーモンとして起動せず、前面で実行するための設定です。これにより、DockerコンテナがNginxプロセスをバックグラウンドで実行し、Dockerコンテナ自体が終了しないようにします。
