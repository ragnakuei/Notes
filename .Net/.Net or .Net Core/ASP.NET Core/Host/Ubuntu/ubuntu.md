# Ubuntu

[Host ASP.NET Core on Linux with Nginx](https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/linux-nginx)

[Install the .NET SDK or the .NET Runtime on Ubuntu](https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu)

### 步驟

- 安裝 CLR

    ```
    wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb

    sudo apt-get update; \
    sudo apt-get install -y apt-transport-https && \
    sudo apt-get update && \
    sudo apt-get install -y aspnetcore-runtime-6.0

    ```
- 建立 Asp.Net Core Mvc 專案
- dotnet publish --configuration Release
- [SCP] 將 bin/Release/[TFM]/publish 資料夾內的資料複製至 ubuntu 中

#### 沒有 Reverse Proxy Server
- dotnet [Web 專案].dll --urls "http://0.0.0.0:5000"
  - 不給定 --urls 0.0.0.0 就只會 listen localhost:5000
  - [其他指定 Listen 的方式](../../Kestrel/指定%20listen%20的方式.md)
- 同區網內主機測試連線 OK

#### 有 Reverse Proxy Server
- 安裝 Nginx

  ```
  sudo apt update
  sudo apt install nginx
  sudo service nginx start
  ```

- /etc/nginx/sites-available/default

  ```
  server {
      listen        80;
      server_name   example.com *.example.com;
      location / {
          proxy_pass         http://127.0.0.1:5000;
          proxy_http_version 1.1;
          proxy_set_header   Upgrade $http_upgrade;
          proxy_set_header   Connection keep-alive;
          proxy_set_header   Host $host;
          proxy_cache_bypass $http_upgrade;
          proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header   X-Forwarded-Proto $scheme;
      }
  }
  ```

- 
- 