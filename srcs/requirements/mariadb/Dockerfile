FROM alpine:3.22

RUN apk update && \
    apk add --no-cache mariadb mariadb-client

RUN mkdir -p /var/lib/mysql /run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /run/mysqld \
    && chmod 777 /run/mysqld

COPY conf/mariadb.cnf /etc/my.cnf.d/mariadb.cnf

COPY tools/mariadb.sh /usr/local/bin/mariadb.sh

RUN chmod +x /usr/local/bin/mariadb.sh

USER mysql

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]
