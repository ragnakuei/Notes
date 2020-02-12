# supervisor設置方式，以sshd、nginx、memcached為例 (ubuntu)

讓docker container：ubuntu可自動啟動 sshd、nginx

---

ubuntu設定如下
- apt install supervisor
- mkdir -p /var/log/supervisor
- vim /etc/supervisor/conf.d/supervisord.conf

```
[supervisord]
nodaemon=true
```

依照要啟動的 service ，再加上以下的語法至 supervisord.conf 中

```
ssh
[program:sshd]
directory=/usr/local/
command=/usr/sbin/sshd -D
autostart=true
autorestart=true
redirect_stderr=true
nginx
[program:nginx]
command=/usr/sbin/nginx -g "daemon off;"
stdout_events_enabled=true
stderr_events_enabled=true
mysql
[program:mysql]
command=/usr/bin/pidproxy /var/run/mysqld/mysqld.pid /usr/sbin/mysqld
autorestart=true

[program:mysqld]
command=/usr/bin/pidproxy /var/mysqld/mysqld.pid /usr/local/mysql/default/bin/mysqld_safe --pid-file=/var/mysqld/mysqld.pid
autostart=true
autorestart=true
user=root
```

php 7.0 fpm
   要記得建立資料夾 mkdir -p /var/log/php-fpm/

```
[program:php-fpm]
command=/usr/sbin/php-fpm7.0 -F
autostart=true
autorestart=unexpected
stdout_logfile=/var/log/php-fpm/stdout.log
stdout_logfile_maxbytes=0
stderr_logfile=/var/log/php-fpm/stderr.log
stderr_logfile_maxbytes=0
exitcodes=0
memcached
[program:memcached]
command=memcached -m 8192 -u root -l 0.0.0.0 -c 10240 -p 11211
numprocs=1
user=root
autostart=true
autorestart=true
stdout_logfile=/var/log/memcached.stdout.log
redirect_stderr=true
stopsignal=QUIT
```

以上設定完畢後，可執行 `/usr/bin/supervisord` 來檢查是否可正常運行

docker建立Container指令如下：
> docker commit ubuntu_1 ubuntu:2

> docker create --name ubuntu_2 -p 22:22 -p 8080:80 ubuntu:2 /usr/bin/supervisord

或是 

> docker run --name ubuntu_2 -p 22:22 -p 8080:80 -d ubuntu:2 /usr/bin/supervisord

> docker run -d --name matomo3 -p 22:22 -p 8080:80 -it matomo:3 /usr/bin/supervisord

> docker start  ubuntu_2
