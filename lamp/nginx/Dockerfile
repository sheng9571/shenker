FROM alpine:3.3

# Patch APK Mirror to YKode
RUN echo "http://dl-4.alpinelinux.org/alpine/v3.3/main" > /etc/apk/repositories

RUN apk add --update nginx && rm -rf /var/cache/apk/* && chown -R nginx:www-data /var/lib/nginx

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/var/log/nginx"]

COPY res/conf/nginx.conf /etc/nginx/nginx.conf
COPY res/conf/default.conf /etc/nginx/conf.d/default.conf
COPY res/html /usr/share/nginx/html

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
