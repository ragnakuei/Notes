# 從部署 Asp Net Core 來解釋 Dockerfile

[參考資料](https://www.ezzylearning.net/tutorial/build-and-run-asp-net-core-apps-in-containers)

---

#### base Stage

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

> 使用 mcr.microsoft.com/dotnet/aspnet:7.0 這個 Docker Image
> 此 Stage 名稱為 base
> 設定工作目錄為 /app
> 開放 80 與 443 port

#### build Stage

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

> FROM 要使用的 Docker Image
> AS Stage Name

WORKDIR /src

> 設定工作目錄
	
COPY ["AspNetCoreDockerDemoApp.csproj", "."]

> COPY [來源路徑] [目的路徑]
> 複製指定檔案到工作目錄
> [來源路徑] 指的是目前 Dockerfile 所在的目錄
> [目的路徑] 指的是 FROM 指定的 Docker Image 內的工作目錄

RUN dotnet restore "./AspNetCoreDockerDemoApp.csproj"

> RUN 指執行右邊的指令
> dotnet restore 指的是執行 dotnet restore 指令
	
COPY . .

> 複製目前 Dockerfile 所在的目錄的所有檔案到工作目錄

WORKDIR "/src/."

> 設定工作目錄
> 總覺得這行沒有必要

RUN dotnet build "AspNetCoreDockerDemoApp.csproj" -c Release -o /app/build

> 執行 dotnet build 指令

#### publish Stage

FROM build AS publish
RUN dotnet publish "AspNetCoreDockerDemoApp.csproj" -c Release -o /app/publish /p:UseAppHost=false

> 此 Stage 接續 Build Stage，並且名稱為 publish
> 執行 dotnet publish 指令


#### final Stage

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "AspNetCoreDockerDemoApp.dll"]

> 此 Stage 接續 base Stage，並且名稱為 final
> 設定工作目錄 /app
> 複製 publish Stage container 的 /app/publish 的所有檔案 到 工作目錄
> 設定 container 啟動時要執行的指令


#### 執行

	
docker build -t myaspnetdockerapp .
docker images
docker run -d -p 8080:80 --name myapp myaspnetdockerapp


docker rmi $(docker images -q)

> 清除所有 dangling images

docker system prune

> 清除所有未使用的 images, containers, volumes, networks
> 使用上要小心，聽說也有機會清除正在執行的 container