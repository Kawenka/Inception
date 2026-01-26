FROM alpine:3.23

RUN apk update && \
    apk add --no-cache mariadb mariadb-client

RUN mkdir -p /var/lib/mysql /run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /run/mysqld \
    && chmod 777 /run/mysqld

EXPOSE 3306