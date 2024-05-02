FROM debian:bullseye

RUN apt update -y && \
	apt upgrade -y && \
	apt install nginx openssl -y

RUN mkdir /etc/nginx/ssl

ARG CERT_PATH
ARG PRIVKEY_PATH
ARG CERT_DETAILS

RUN openssl req \
	-newkey rsa:4096 \
	-x509 \
	-sha256 \
	-days 365 \
	-nodes \
	-out $CERT_PATH \
	-keyout $PRIVKEY_PATH \
	-subj $CERT_DETAILS

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
