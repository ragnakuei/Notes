# [microsoft/mssql-server-linux](https://docs.microsoft.com/zh-tw/sql/linux/sql-server-linux-configure-docker)

- [microsoft/mssql-server-linux](#microsoftmssql-server-linux)
  - [執行 sqlcmd 的方式](#%e5%9f%b7%e8%a1%8c-sqlcmd-%e7%9a%84%e6%96%b9%e5%bc%8f)
  - [指定 volume 掛載 mdf](#%e6%8c%87%e5%ae%9a-volume-%e6%8e%9b%e8%bc%89-mdf)
  - [複製 mdf 至 container 內](#%e8%a4%87%e8%a3%bd-mdf-%e8%87%b3-container-%e5%85%a7)

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

```dockerfile
docker cp /tmp/mydb.mdf d6b75213ef80:/var/opt/mssql/data
```
