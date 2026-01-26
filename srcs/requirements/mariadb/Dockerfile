FROM alpine:3.23

RUN apk update && \
    apk add --no-cache mariadb mariadb-client

RUN mkdir -p var/lib/mysql 