# Dockerfile

- [Dockerfile](#dockerfile)
  - [範例](#%e7%af%84%e4%be%8b)
- [dockerignore](#dockerignore)
  - [參考資料](#%e5%8f%83%e8%80%83%e8%b3%87%e6%96%99)

---

重點
- 主檔名一定要為 Dockerfile
- 執行方式：`docker build -t ContainerName .`

    最後有一個 . 是指當前執行命令的目錄，會在此目錄下尋找 Dockerfile 並套用

- `docker build -t -f dockerfile_path`
	
	
env 的使用
1. 換行串接用 \
1. 呼叫變數用 $env:變數名

```docker
FROM microsoft/mssql-server-windows-express

ENV sa_password="zzz@ZZZ" \
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
- https://philipzheng.gitbooks.io/docker_practice/content/dockerfile/basic_structure.html
- https://philipzheng.gitbooks.io/docker_practice/content/dockerfile/instructions.html
- http://dockone.io/article/103