
```docker
docker run -d --name winMSSQL -p 1433:1433 -e sa_password=xxxxx -e ACCEPT_EULA=Y microsoft/mssql-server-windows
```