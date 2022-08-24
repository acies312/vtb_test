FROM ubuntu:latest

COPY ./conf ./docker/lb/entrypoint.sh /tmp/

RUN \
    apt-get update && \
    apt-get install -y \
    vim inetutils-ping iproute2 curl rsyslog haproxy keepalived && \
    rm -rf /var/lib/apt/lists/* && \
    sed -i 's/^\(module.*imklog.*\)/# \1/g' /etc/rsyslog.conf && \
    cp /tmp/entrypoint.sh / && \
    mkdir /etc/ssl && cp -r /tmp/ssl/* /etc/ssl && \
    cp /tmp/samples/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg && \
    cp /tmp/samples/keepalived/keepalived-master.conf /etc/keepalived/keepalived.conf && \
    chmod +x /entrypoint.sh && \
    rm -r /tmp/*

EXPOSE 8080 8443 8090 80 443

ENTRYPOINT ["entrypoint.sh"]

CMD ["tail", "-f", "/dev/null"]