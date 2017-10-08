跑在 docker 里的 google 镜像
======

简单两步获得 Google 镜像，使用方法：

```
git clone https://github.com/yifeikong/docker_google_mirror
# 需要把所有用到的域名替换成你自己的域名
cd docker_google_mirror
docker build -t google_mirror .
docker run -d --rm -p 80:80 -p 443:443 google_mirror
```

使用了letsencrypt的免费https证书. 注意每次run都会去申请新的证书,
而letsencrypt是有频次限制的, 所以不要过度频繁生成container


致谢
------

其实这只是强大的[Google Filter Module](https://github.com/cuber/ngx_http_google_filter_module)的一个容器而已啦
