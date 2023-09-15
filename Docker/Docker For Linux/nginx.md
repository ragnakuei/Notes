# [nginx](https://hub.docker.com/_/nginx)

```sh
docker pull nginx
```

建立一個 nginx container
- name: nginx01
- port mapping: localhost:8080 > container:80
- detach: -d
- from image: nginx

```sh
docker run --name nginx01 -d -p 8080:80 nginx
```
