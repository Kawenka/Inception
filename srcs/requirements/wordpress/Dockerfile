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
        php-redis \
        wget \
        mariadb-client

RUN wget --quiet https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN adduser -S www-data -G www-data

RUN sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php*/php-fpm.d/www.conf && \
    sed -i '/^user =/d' /etc/php*/php-fpm.d/www.conf && \
    sed -i '/^group =/d' /etc/php*/php-fpm.d/www.conf

COPY tools/wordpress.sh /usr/local/bin/wordpress.sh

RUN chmod +x /usr/local/bin/wordpress.sh

RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html /var/log/php83

USER www-data

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress.sh"]
