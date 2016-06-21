# 在 docker 里的 google 镜像

简单两步获得 Google 镜像，使用方法：

```shell
git clone https://github.com/jhezjkp/docker-google-mirror
cd docker-google-mirror
#添加自己的域名证书到该目录下
cp ~/ssl.csr domain.csr
cp ~/ssl.key.unsecure domain.key.unsecure
docker build -t google-mirror .
docker run -d -p 80:80 -p 443:443 google-mirror
```

## 备注

[Nginx 配置 SSL 证书 + 搭建 HTTPS 网站教程](https://s.how/nginx-ssl/)

去除证书phrase的命令：

```shell
openssl rsa -in server.key -out server.key.unsecure
```

