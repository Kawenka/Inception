FROM alpine:3.22

RUN apk update && apk add --no-cache vsftpd

COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY tools/ftp-server.sh /tmp/ftp-server.sh

RUN chmod +x /tmp/ftp-server.sh

EXPOSE 20/tcp 21/tcp 40000-40009/tcp

ENTRYPOINT ["/tmp/ftp-server.sh"]
CMD ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]
