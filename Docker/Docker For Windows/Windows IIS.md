# [Windows IIS](https://hub.docker.com/_/microsoft-windows-servercore-iis)

> docker run -it --name iis01 -p 8080:80 mcr.microsoft.com/windows/servercore/iis
> docker run -d --name iis01 -p 8080:80 --isolation=process mcr.microsoft.com/windows/servercore/iis

> docker cp iis01:/inetpub/wwwroot C:\temp\HelloWorld.html