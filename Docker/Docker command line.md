# [Docker command line](https://docs.docker.com/engine/reference/commandline/cli/)

- [Docker command line](#docker-command-line)
  - [建立 Image 前](#建立-image-前)
    - [search](#search)
    - [pull](#pull)
    - [network](#network)
    - [ps](#ps)
    - [images](#images)
  - [建立 Image 後](#建立-image-後)
    - [attach](#attach)
    - [exec](#exec)
    - [start](#start)
    - [stop](#stop)
    - [rename](#rename)
    - [run](#run)
    - [rm](#rm)
    - [rmi](#rmi)
    - [commit](#commit)
    - [create](#create)
    - [logs](#logs)
  - [參考資料](#參考資料)

---

## 建立 Image 前

### search

以 keyword 搜尋 docker hub

> docker search [keyword]

---

### pull

下載 ubuntu latest 的版本

> docker pull ubuntu:latest

### [network](https://docs.docker.com/engine/reference/commandline/network/)

管理網路

---

### ps

列出正在執行的 Container	
> docker ps

列出所有的 Container

> docker ps -a

---

### images

列出可執行的 Image

> docker images

---

## 建立 Image 後

---

### attach

> 等於 docker container attach

進入到 ubuntu 的 container 中

> docker attach ubuntu

離開 container 但不要停止 container，可以使用 detach 的快捷鍵 `Ctrl + p` `Ctrl + q`

---

### exec

> 等於 docker container exec

登入指定的 Container 後，進入到 bash 中

> docker exec -it CONTAINER_ID bash

登入指定的 Container 後，進入 powershell 中

> docker exec -it CONTAINER_ID powershell

登入指定的 Container 後，執行 ipconfig 指令

> docker exec CONTAINER_ID ipconfig	


---

### start

> 等於 docker container start

啟動有 Image 的 Container

> docker start ContainerName

> docker start ContainerID		

---

### stop

> 等於 docker container stop

停止 Container
> docker stop CONTAINER_ID

---

### rename

指定 CONTAINER_ID 的名稱為 name

> docker rename CONTAINER_ID name

---

### [run](https://docs.docker.com/engine/reference/commandline/run/)

> 等於 docker container run

下載並執行 ubuntu 14.04 的版本 執行完就會立即停止

> docker run ubuntu:14.04

- -d 以離線方式執行
- -it 於 tty 中執行 command
- --rm 如果存在，就刪除，再重建
  - 可以跟 -it 一起使用，就不用再手動刪除
- --restart always 如果關閉，會自動重啟

透過 Image：nginx 產生 Container：nginx1，給定執行COMMAND：/sbin/init

> docker run --name nginx1 -d nginx /sbin/init

以Image：ubuntu-upstart-02

來建立 & 執行 Container ubuntu-upstart-03

> docker run -d --name ubuntu-upstart-03 ubuntu-upstart-02

建立 hello，並連結至 redis

> docker run -d --link redis:redis -p 80:8080 hello

啟動mysql

> docker run -d --name my-db -e MYSQL_ROOT_PASSWORD=1234 mysql

啟動redis

> docker run -d --name my-redis redis

連結 mysql 及 redis

> docker run -it --link my-db:db --link myredis:redis ubuntu /bin/bash

如果沒有 mysql，就會下載，並執行 MySQL 的 Container

如果沒有 wordpress，就會下載，並執行 wordpress & 連結 mysql

> docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=password -d mysql:latest
> docker run --name mywp --link mysql -d -p 8080:80 wordpress

以image dotnet:1產生container dotnet1，並以/bin/bash登入

以image id 產生container memcached，並以/bin/bash登入

> docker run --name dotnet1 -p 50022:22 -it dotnet:1 /bin/bash
> docker run --name memcached -p 50022:22 -it fcd70541c586 /bin/bash

docker run -d --network=mybridge --ip=192.168.17.3 -p 8000:80 dotnetnano


---

### rm

> 等於 docker container rm

刪除指定的 Container

> docker rm [CONTAINER_ID | CONTAINER_NAME]

---

### rmi

刪除指定的 Image

> docker rmi IMAGE_ID

---

### commit

複製既有的 CONTAINER_ID 為 新的 Image test

> docker commit CONTAINER_ID test

複製 ubuntu-upstart 為 新的 TAG：1	

Image ubuntu-upstart-01 一但宣告了 TAG 後，之後使用都要帶上 Image:Tag 的寫法

> docker commit ubuntu-upstart ubuntu-upstart-01:1

建立以 ubuntu-upstart 做為 reference 的 ubuntu-upstart-01

可用來做 Snapshot

> docker commit -p ubuntu-upstart ubuntu-upstart-01	

建立 Container，名稱：A 使用的 Image：B 登入的 Command：/sbin/init 

---

### create

格式：docker create [OPTIONS] IMAGE [COMMAND]	

> docker create --name A B /sbin/init	

8080 是指本機的 port，80 是指 dokcer container 內的 port

> docker create --name ubuntu_1 -p 8080:80 ubuntu:1 /sbin/init

可同時指定二組以上的 port mapping

> docker create --name ubuntu_1 -p 8080:80 -p 22:22 ubuntu:1 /sbin/init

---

### [logs](https://docs.docker.com/engine/reference/commandline/logs/)

取出指定的 container 的 log

---

## 參考資料

- [Docker run 命令的使用方法](http://dockone.io/article/152)