# [microsoft/aspnetcore](https://hub.docker.com/r/microsoft/aspnetcore/)

- [microsoft/aspnetcore](#microsoftaspnetcore)
  - [範例](#%e7%af%84%e4%be%8b)
  - [參考資料](#%e5%8f%83%e8%80%83%e8%b3%87%e6%96%99)

---

## 範例

建立資料夾 aspnet_core

- 裡面放 Dockerfile & app 資料夾
- 將 asp.net core 編譯輸出資料指定為 app 那個路徑

Dockerfile 內容如下

    藍字替換為 asp.net core 程式的主要 dll

```docker
FROM microsoft/aspnetcore
WORKDIR /app
COPY ./app .
ENTRYPOINT ["dotnet", "myapp.dll"]
```

asp.net core 編譯完，注意主要執行的 dll ，主檔名通常是執行專案的名稱

> docker build -t myaspnetcore .\aspnet_core\

> docker run -d -p 8080:80 myaspnetcore --name myaspnetcore01

---

## 參考資料

- [A better look at Dockerfiles: creating a container with Rider](https://blog.jetbrains.com/dotnet/2019/05/24/better-look-dockerfiles-creating-container-rider/)

