FROM alpine:3.6
MAINTAINER Yifei Kong <kong@yifei.me>

ENV NGINX_VER 1.10.0

# install nginx with google mirror module
RUN apk add --update git openssl-dev pcre-dev zlib-dev wget build-base certbot && \
    mkdir src && cd src && \
    wget http://nginx.org/download/nginx-${NGINX_VER}.tar.gz && \
    tar xzf nginx-${NGINX_VER}.tar.gz && \
    git clone https://github.com/cuber/ngx_http_google_filter_module && \
    git clone https://github.com/yaoweibin/ngx_http_substitutions_filter_module && \
    cd nginx-${NGINX_VER} && \
    ./configure --prefix=/opt/nginx \
        --with-http_ssl_module \
        --add-module=../ngx_http_google_filter_module \
        --add-module=../ngx_http_substitutions_filter_module && \
    make && make install && \
    apk del git build-base && \
    rm -rf /src && \
    rm -rf /var/cache/apk/*

# add config files
COPY ssl.conf /opt/nginx/conf/ssl.conf
COPY letsencrypt.conf /opt/nginx/conf/letsencrypt.conf
COPY nginx_http_only.conf /opt/nginx/conf/nginx_http_only.conf
COPY nginx.conf /opt/nginx/conf/nginx.conf
COPY start.sh /start.sh

# set up renew cron jobs
RUN echo '8 0 * * * certbot renew --noninteractive --renew-hook "/opt/nginx/sbin/nginx -s reload" > /dev/null 2>&1' > /crontab

EXPOSE 80 443

# start nginx and cron in the background
CMD ["/start.sh"]
