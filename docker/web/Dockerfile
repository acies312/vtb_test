FROM nginx

COPY ./conf ./docker/web/entrypoint.sh /tmp/

RUN \
    apt-get update && \
    apt-get install --no-install-recommends --no-install-suggests -y \
    vim && \
    rm -rf /var/lib/apt/lists/* && \
    cp /tmp/entrypoint.sh / && \
    cp -r /tmp/samples/nginx/* /etc/nginx/conf.d/ && \
    cp -r /tmp/ssl/* /etc/ssl/ && \
    chmod +x /entrypoint.sh && \
    rm -r /tmp/*

EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]

CMD ["tail", "-f", "/dev/null"]
