# [microsoft/aspnet](https://hub.docker.com/r/microsoft/aspnet/)

- [microsoft/aspnet](#microsoftaspnet)
  - [使用 image 注意事項](#%e4%bd%bf%e7%94%a8-image-%e6%b3%a8%e6%84%8f%e4%ba%8b%e9%a0%85)
  - [方式一:使用官方的的 image 建立 iis container](#%e6%96%b9%e5%bc%8f%e4%b8%80%e4%bd%bf%e7%94%a8%e5%ae%98%e6%96%b9%e7%9a%84%e7%9a%84-image-%e5%bb%ba%e7%ab%8b-iis-container)
  - [方式二:透過 dockerfile](#%e6%96%b9%e5%bc%8f%e4%ba%8c%e9%80%8f%e9%81%8e-dockerfile)

---

## 使用 image 注意事項

    • iis 的 web folder 在 c:\inetput\wwwroot\ 中
    • 可透過執行 powershell 進入

## 方式一:使用官方的的 image 建立 iis container

> docker run -it --name iis microsoft/aspnet -p 8080:80

## 方式二:透過 dockerfile

1.  建立 iis image

    - Dockerfile

      mvc 編譯後的檔案 放在 aspnet\site 資料夾中

      將本機的資料 COPY 到 container 中

      ```docker
      FROM microsoft/aspnet

      EXPOSE 8080

      COPY ./Site/ /inetpub/wwwroot/
      ```

    dockerfile 放在 aspnet 資料夾中

    > build dockerfile 
    
    > docker build -t aspnet_mvc .\aspnet

1.  使用上述的 image 建立 iis container
    docker run -it -d --name aspnet_mvc_01 aspnet_mvc

1.  進入 iisContainer 中
    docker exec -it aspnet_mvc_01 powershell

1.  取得 container ip
    docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" aspnet_mvc_01
