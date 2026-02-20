FROM alpine:3.22

RUN apk update && apk add --no-cache lighttpd

COPY tools/index.html /var/www/localhost/htdocs/index.html

EXPOSE 80

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
