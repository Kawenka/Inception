FROM alpine:3.22

RUN apk add --no-cache php \
      php-mysqli \
      php-session \
      wget

RUN wget https://www.adminer.org/latest-mysql.php -O index.php

CMD ["php", "-S", "0.0.0.0:8080"]