# Dockerfile

- [Dockerfile](#dockerfile)
  - [範例](#%e7%af%84%e4%be%8b)
  - [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
  - Linting tools
  - ★ [Windows Container Samples](https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/windows-container-samples/asp-net-getting-started)

- [dockerignore](#dockerignore)
  - [參考資料](#%e5%8f%83%e8%80%83%e8%b3%87%e6%96%99)

---

重點
- 主檔名一定要為 Dockerfile
- 執行方式：`docker build -t ImageName .`

  - -t 是指定 image 的名稱 
  - --no-cache 是指不使用前一次快取

  - . 是指當前執行命令的目錄，會在此目錄下尋找 Dockerfile 並套用

  - `docker build -t -f dockerfile_path`
	
### Dockerfile 指令
	
ENV 的使用
1. 換行串接用 \
1. 呼叫變數用 $env:變數名

LABEL
  - 等於用來註解，可以用來搜尋

FROM 
  - 指定 base image

WORKDIR
  - 指定工作目錄

ADD
  - 將檔案複製到 image 中

COPY
  - 將檔案複製到 image 中

EXPOSE
  - 指定 container 對外的 port

VOLUMN
  - 指定 container 的 volume
  - VOLUMN ["C:/inetpub/wwwroot"]

SHELL
  - 指定 shell
  - Windows Container 下，預設是 cmd
  - 範例
    - Linux
      - SHELL ["/bin/bash", "-c"]
    - Windows
      - SHELL ["cmd", "/S", "/C"]
      - SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENTRYPOINT
  - 指定 container 啟動時要執行的命令
  - ENTRYPOINT ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
  - ENTRYPOINT powershell arg1 arg2

CMD
  - 指定 container 啟動時要執行的命令
  - CMD ["executable","param1","param2"]
  - CMD ["param1","param2"]
  - CMD command arg1 arg2

RUN
  - 執行命令
  - RUN command arg1
  - RUN ["executable","param1","param2"]
  - 每執行一次 RUN，就會產生一個 image layer







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
- Top 20 Dockerfile best practices
- https://philipzheng.gitbooks.io/docker_practice/content/dockerfile/basic_structure.html
- https://philipzheng.gitbooks.io/docker_practice/content/dockerfile/instructions.html
- http://dockone.io/article/103