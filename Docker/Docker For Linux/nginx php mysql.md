# nginx php mysql

http://blog.chengweichen.com/2015/05/docker-nginx-php-fpm-52-mysql.html

http://paulfun.net/wordpress/?p=27

http://geekyplatypus.com/dockerise-your-php-application-with-nginx-and-php7-fpm/

docker-compose.yml

```yml
nginx:
    image: nginx:latest
    ports:
        - '80:80'
    volumes:
        - ./nginx:/etc/nginx/conf.d
        - ./logs/nginx:/var/log/nginx
        - ./wordpress:/var/www/html
    links:
        - wordpress
    restart: always
mysql:
    image: mariadb
    ports:
        - '3306:3306'
    volumes:
        - ./db-data:/var/lib/mysql
    environment:
        - MYSQL_ROOT_PASSWORD=aqwe123
    restart: always
```
