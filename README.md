跑在 docker 里的 google 镜像
======

简单两步获得 Google 镜像，使用方法：

```
git clone https://github.com/yifeikong/docker-google-mirror
cd docker-google-mirror
docker build -t google-mirror .
docker run -d -p 80:80 google-mirror
```

配置https

1. 编辑Dockerfile文件,注释第22行，并解注释第24、25行
2. 申请域名证书，具体参考[Get Https For Free](https://gethttpsforfree.com/)
3. 添加自己的域名证书到该目录下

```shell
cd docker-google-mirror
cp ~/chained.pem ~/domain.key ~/dhparam.pem . # 把对应文件拷过来
docker build -t google-mirror .
docker run -d -p 80:80 -p 443:443 google-mirror
```

致谢
------

其实这只是强大的[Google Filter Module](https://github.com/cuber/ngx_http_google_filter_module)的一个容器而已啦
