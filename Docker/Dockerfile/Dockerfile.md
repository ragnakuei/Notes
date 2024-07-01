# Dockerfile

-   [Dockerfile](#dockerfile)

    -   [範例](#%e7%af%84%e4%be%8b)
    -   [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
    -   Linting tools
    -   ★ [Windows Container Samples](https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/windows-container-samples/asp-net-getting-started)

-   [dockerignore](#dockerignore)
    -   [參考資料](#%e5%8f%83%e8%80%83%e8%b3%87%e6%96%99)

---

重點

-   主檔名一定要為 Dockerfile
-   執行方式：`docker build -t ImageName .`

    -   -t 是指定 image 的名稱
    -   --no-cache 是指不使用前一次快取

    -   . 是指當前執行命令的目錄，會在此目錄下尋找 Dockerfile 並套用

    -   `docker build -t -f dockerfile_path`

### Dockerfile 指令

ENV 的使用

1. 換行串接用 \
1. 呼叫變數用 $env:變數名

LABEL

-   等於用來註解，可以用來搜尋

FROM

-   指定 base image

WORKDIR

-   指定工作目錄

ADD

-   將檔案複製到 image 中

COPY

-   將檔案複製到 image 中

EXPOSE

-   指定 container 對外的 port

VOLUMN

-   指定 container 的 volume
-   VOLUMN ["C:/inetpub/wwwroot"]

SHELL

-   指定 shell
-   Windows Container 下，預設是 cmd
-   範例
    -   Linux
        -   SHELL ["/bin/bash", "-c"]
    -   Windows
        -   SHELL ["cmd", "/S", "/C"]
        -   SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENTRYPOINT

-   指定 container 啟動時要執行的命令
-   ENTRYPOINT ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
-   ENTRYPOINT powershell arg1 arg2

CMD

-   指定 container 啟動時要執行的命令
-   CMD ["executable","param1","param2"]
-   CMD ["param1","param2"]
-   CMD command arg1 arg2

RUN

-   執行命令
-   RUN command arg1
-   RUN ["executable","param1","param2"]
-   每執行一次 RUN，就會產生一個 image layer

---

### WORKDIR 跟 cd 的差異

在 Dockerfile 中，WORKDIR 與 cd 都用於設定工作目錄（工作路徑），但有些微妙的差異：

WORKDIR 指令：

-   WORKDIR 是 Dockerfile 的指令，用於設定在後續指令中執行的命令的工作目錄。
-   你可以使用 WORKDIR 一次性設定多個指令的工作目錄，在這個目錄中執行後續的命令。
-   WORKDIR 指令也可以遞迴設定工作目錄，也就是在已經設定的工作目錄上再次設定新的工作目錄。
-   若要指定 WORKDIR 中的路徑，需使用絕對路徑。

cd 命令：

-   cd 是 shell（如 Bash）的命令，用於更改當前工作目錄。
-   在 Dockerfile 中，你可以使用 RUN cd /path/to/directory 來更改當前目錄，但這僅適用於當前命令，不會影響後續的指令。
-   如果使用 cd 來更改目錄，其效果僅限於該特定的 RUN 指令。

總之，主要的差異在於 WORKDIR 是 Dockerfile 的內建指令，可以永久地設定工作目錄，而
cd 是 shell 的命令，僅在特定命令執行期間更改工作目錄。因此，如果你希望在整個 Dockerfile 中設定一個特定的工作目錄，建議使用 WORKDIR

---

### 範例

```docker
FROM microsoft/mssql-server-windows-express

ENV sa_password="password" \
    ACCEPT_EULA="Y"
    sa_password_path="C:\ProgramData\Docker\secrets\sa-password"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

CMD .\start -sa_password $env:sa_password -ACCEPT_EULA $env:ACCEPT_EULA -Verbose
```

---

## 範例

```docker
version: '2'

services:
  damienbodpostgres:
     image: damienbodpostgres
     restart: always
     build:
       context: .
       dockerfile: Dockerfile
     ports:
       - 5432:5432
     environment:
         POSTGRES_PASSWORD: damienbod
     volumes:
       - pgdata:/var/lib/postgresql/data

volumes:
  pgdata:
```

---

# [dockerignore](https://docs.docker.com/engine/reference/builder/#dockerignore-file)

---

## 參考資料

-   Top 20 Dockerfile best practices
-   https://philipzheng.gitbooks.io/docker_practice/content/dockerfile/basic_structure.html
-   https://philipzheng.gitbooks.io/docker_practice/content/dockerfile/instructions.html
-   http://dockone.io/article/103
