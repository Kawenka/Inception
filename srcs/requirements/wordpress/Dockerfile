FROM alpine:3.22

RUN apk update

RUN apk add --no-cache php \
        php-mysqli \
        php-mbstring \
        php-curl \
        php-fpm \
        php-json \
        php-xml \
        php-openssl \
        php-zip \
        php-gd \
        php-session \
        php-tokenizer \
        php-iconv \
        php-phar \
        wget \
        mariadb-client

RUN sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php83/php-fpm.d/www.conf

COPY tools/wordpress.sh /usr/local/bin/wordpress.sh

RUN chmod +x /usr/local/bin/wordpress.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress.sh"]