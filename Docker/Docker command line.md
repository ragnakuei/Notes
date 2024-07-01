# [Docker command line](https://docs.docker.com/engine/reference/commandline/cli/)

- [Docker command line](#docker-command-line)
  - [建立 Image 前](#建立-image-前)
    - [search](#search)
    - [pull](#pull)
    - [push](#push)
    - [network](#network)
    - [ps](#ps)
    - [image](#image)
    - [images](#images)
  - [建立 Image 後](#建立-image-後)
    - [container](#container)
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
    - [version](#version)
    - [info](#info)
    - [login](#login)
    - [logs](#logs)
  - [參考資料](#參考資料)

---

## 建立 Image 前

### search

以 keyword 搜尋 docker hub

> docker search [keyword]

---

### pull

-   [image]
    -   格式支援以下幾種
        -   ubuntu
            -   通常是指 tag latest
        -   ubuntu:22.04
        -   amd64/ubuntu:22.04

下載 ubuntu latest 的版本

> docker pull ubuntu:latest

### push

上傳 image 到 docker hub

> docker push [IMAGE_NAME]:[TAG]

### [network](https://docs.docker.com/engine/reference/commandline/network/)

管理網路

---

### ps

列出正在執行的 Container

> docker ps

列出所有的 Container

> docker ps -a

---

### image

-   ls
    -   同 docker images
-   pull [image]
    -   同 docker pull [image]
-   inspect [image]
    -   顯示 image 的詳細資訊
-   rm [image]
    -   刪除 image
-   save [image][:tag] -o xxx
    -   將 image 輸出成檔案 xxx
-   load -i xxx
    -   從檔案 xxx 讀取為 image
-   build
    -   -t [ImageName]
    -   [Dockerfile]
-   tag
    -   [Old_Image] [New_Image]
    -   複製 Old Image 為 New Image
-   push [Image]
    -   Image 必須是自己的 docker id 開頭，例：ragnakuei/test:1.0

docker image 的管理

> docker image
> docker image ls

取得指定的 docker image

> docker image pull [IMAGE_NAME]:[TAG]

看指定的 image 的資訊

> docker image inspect [IMAGE_ID | IMAGE_NAME]:[TAG]
> docker image inspect ubuntu:latest

(Windows PowerShell)
查看指定的 image 的資訊，將 JSON 格式 轉一般的物件

> docker image inspect ubuntu:latest | ConvertFrom-Json
> 從一般物件取出指定的屬性
> (docker image inspect ubuntu:latest | ConvertFrom-Json).OsVersion
> 查看該 image 的 expose port
> (docker image inspect ubuntu:latest | ConvertFrom-Json).ContainerConfig.ExposedPorts

刪除指定的 image

> docker image rm [IMAGE_ID | IMAGE_NAME]

### images

列出可執行的 Image

> docker images

等同於

> docker image ls

---

## 建立 Image 後

### container

-   ls
-   ps
    -   -a
    -   -aq 列出所有正在執行的 container ID
-   run [image]
-   commit [container] [repository[:Tag]]
    -   將 container 打包回 image

### attach

```sh
docker attach [container]
```

一般來說，不建議以 attach 模式執行 container
也很少會以 attach 來執行 container

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

-   可以用該 ContainerID 的前幾碼

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

-   -d > 以離線方式執行
-   -it > 於 tty 中執行 command
-   --rm > container 停止後，就刪除，或是，以重建的方式建立 container
    -   可以跟 -it 一起使用，就不用再手動刪除
-   --restart always > 如果關閉，會自動重啟
-   --entrypoint > 覆寫既有的 command 來指定執行的 command
    -   可以用來直接 debug image，當 deubg 完，就可以刪除 container

透過 Image：nginx 產生 Container：nginx1，給定執行 COMMAND：/sbin/init

> docker run --name nginx1 -d nginx /sbin/init

以 Image：ubuntu-upstart-02

來建立 & 執行 Container ubuntu-upstart-03

> docker run -d --name ubuntu-upstart-03 ubuntu-upstart-02

建立 hello，並連結至 redis

> docker run -d --link redis:redis -p 80:8080 hello

啟動 mysql

> docker run -d --name my-db -e MYSQL_ROOT_PASSWORD=1234 mysql

啟動 redis

> docker run -d --name my-redis redis

連結 mysql 及 redis

> docker run -it --link my-db:db --link myredis:redis ubuntu /bin/bash

如果沒有 mysql，就會下載，並執行 MySQL 的 Container

如果沒有 wordpress，就會下載，並執行 wordpress & 連結 mysql

> docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=password -d mysql:latest
> docker run --name mywp --link mysql -d -p 8080:80 wordpress

以 image dotnet:1 產生 container dotnet1，並以/bin/bash 登入

以 image id 產生 container memcached，並以/bin/bash 登入

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

### version

### info

### login

-   登入至 docker hub，後續可將 docker image push 至 docker hub 上

### [logs](https://docs.docker.com/engine/reference/commandline/logs/)

取出指定的 container 的 log

---

## 參考資料

-   [Docker run 命令的使用方法](http://dockone.io/article/152)
