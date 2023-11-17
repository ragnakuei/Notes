# mcr.microsoft.com/mssql/server

## tag 2022-latest

```bash
sudo docker pull mcr.microsoft.com/mssql/server:2022-latest

sudo docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=YourStrong@Passw0rd" -p 1433:1433 --name sql1 --hostname sql1    -d    mcr.microsoft.com/mssql/server:2022-latest

docker exec -t sql1 cat /var/opt/mssql/log/errorlog | grep connection
```

進入 container 中的 bash

```bash
sudo docker exec -it sql1 "bash"
```

在 bash 中執行 sqlcmd

```bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'YourStrong@Passw0rd'
```

