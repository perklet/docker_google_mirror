FROM alpine:3.2
MAINTAINER Yifei Kong <kong@yifei.me>

ENV NGINX_VER 1.10.0

RUN apk add --update git openssl-dev pcre-dev zlib-dev wget build-base && \
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

ADD nginx.conf /opt/nginx/conf/nginx.conf
#如果需要https支持则注释上一行并解注释下两行
#ADD nginx-https.conf /opt/nginx/conf/nginx.conf
#ADD domain.csr domain.key.unsecure /etc/ssl/private/

EXPOSE 80 443
CMD ["/opt/nginx/sbin/nginx", "-g", "daemon off;"]
