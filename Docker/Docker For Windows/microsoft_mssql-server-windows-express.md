# [microsoft/mssql-server-windows-express]()

- [microsoft/mssql-server-windows-express](#microsoftmssql-server-windows-express)
  - [docker compose sample 1](#docker-compose-sample-1)


https://www.youtube.com/watch?v=chAc2VDW-NQ
https://dotblogs.com.tw/swater111/2017/01/16/183653


建立 Container

```dockerfile
docker run -d --name winMSSQL -p 1433:1433 -e sa_password=xxxxx -e ACCEPT_EULA=Y microsoft/mssql-server-windows-express
```

取得 Container IP

> docker inspect --format='{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' winMSSQL

## docker compose sample 1

```yml
version: '3.4'

services:
  webpresentation:
    image: webpresentation
    build:
      context: .
      dockerfile: WebPresentation\Dockerfile

  db:
    image: microsoft/mssql-server-windows-express
    environment:
      ACCEPT_EULA: Y
      SA_PASSWORD: Test1
      attach_dbs: '[{"dbName":"MyProject","dbFiles":["C:\\DockerDbData\\MyProject.mdf","C:\\DockerDbData\\MyProject_log.ldf"]}]'

    ports:
      - "1433:1433"
    volumes:
      - "C:\\Projects\\MyProject\\DockerDbDataVolume:C:\\DockerDbData"
```
