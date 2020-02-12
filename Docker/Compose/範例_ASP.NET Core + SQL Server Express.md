# 範例 ASP.NET Core + SQL Server Express

```json
version: '2.1'

services:
  db:
    image: microsoft/mssql-server-windows-express
    environment:
      sa_password: "password"
      ACCEPT_EULA: "Y"
    healthcheck:
      test: [ "CMD", "sqlcmd", "-U", "sa", "-P", "password", "-Q", "select 1" ]
      interval: 2s
      retries: 10

  app:
    image: microsoft/aspnetcore1
    build:
      context: ./aspnet_core
      dockerfile: Dockerfile
    # environment:
    #   - "Data:useSqLite=false"
    #   - "Data:SqlServerConnectionString=Server=db;Database=Test;User Id=sa;Password=password;MultipleActiveResultSets=true;App=Test"
    depends_on:
      db:
        condition: service_healthy
    ports:
      - "8080:80"

networks:
  default:
    external:
      name: nat

```