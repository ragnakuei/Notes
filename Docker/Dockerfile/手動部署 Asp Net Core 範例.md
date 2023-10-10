# 手動部署 Asp Net Core 範例


### 範例 1

dotnet publish -c Release -o dist

dockerfile

```dockerfile
FROM mcr.microsoft.com/dotnet/core/aspnet
LABEL author="Name"

ENV ASPNETCORE_URLS=http://*:5000
ENV ASPNETCORE_ENVIRONMENT="production"

EXPOSE 5000
WORKDIR /app
COPY ./dist . 
ENTRYPOINT ["dotnet", "Your-Project-Name.dll"]
```

docker build -t my-dev-image-name .

### 範例 2

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:6.0 as build-env
WORKDIR /src
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o /publish

FROM mcr.microsoft.com/dotnet/aspnet:6.0 as runtime
WORKDIR /publish
COPY --from=build-env /publish .
ENV ASPNETCORE_URLS=http://+:5000
EXPOSE 5000
ENTRYPOINT ["dotnet", "HelloDocker.dll"]
```