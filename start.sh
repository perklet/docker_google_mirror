#!/bin/sh

if [ ! -d /etc/letsencrypt/live/g.yifei.me/ ]; then
    /opt/nginx/sbin/nginx -c /opt/nginx/conf/nginx_http_only.conf
    mkdir -p /opt/nginx/html/.well-known/acme-challenge
    certbot certonly --webroot --agree-tos --no-eff-email --email kongyifei@gmail.com \
    -w /opt/nginx/html -d g.yifei.me
    /opt/nginx/sbin/nginx -s stop
fi

# start nginx
/opt/nginx/sbin/nginx
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start nginx: $status"
  exit $status
fi

# start certbot cron
crond -c /crontab
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start crond: $status"
  exit $status
fi

while true; do
  ps aux |grep nginx |grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux |grep crond |grep -q -v grep
  PROCESS_2_STATUS=$?
  # If the greps above find anything, they will exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit -1
  fi
  sleep 60
done

