# [microsoft/mssql-server-linux](https://docs.microsoft.com/zh-tw/sql/linux/sql-server-linux-configure-docker)

- [microsoft/mssql-server-linux](#microsoftmssql-server-linux)
  - [執行 sqlcmd 的方式](#執行-sqlcmd-的方式)
  - [指定 volume 掛載 mdf](#指定-volume-掛載-mdf)
  - [複製 mdf 至 container 內](#複製-mdf-至-container-內)

## 執行 sqlcmd 的方式

以 bash 方式進入 container

> docker exec -it linsql bash

執行 sqlcmd

> /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P xxx

## 指定 volume 掛載 mdf

```dockerfile
docker run -e "ACCEPT_EULA=Y"
           -e "SA_PASSWORD=MyStrongPassword"
           --cap-add SYS_PTRACE
           -u (id -u myusername):(id -g myusername)
           -v /path/to/mssql:/var/opt/mssql
           -p 1433:1433
           -d mcr.microsoft.com/mssql/server:2019-latest
```

## 複製 mdf 至 container 內

從本機的 DB 複製到與 Container 共用的資料夾時，需要複製下面二個檔案

-   .mdf
-   \_log.ldf

並且在掛載時，二個檔案都要指定 !

```dockerfile
docker cp /tmp/mydb.mdf d6b75213ef80:/var/opt/mssql/data
```
