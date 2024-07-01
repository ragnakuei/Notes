## AspNetCoreDocker

appsettings.json

```json
{
    "Logging": {
        "LogLevel": {
            "Default": "Information",
            "Microsoft.AspNetCore": "Warning"
        }
    },
    "ConnectionStrings": {
        "DefaultConnection": "Server=mssql;Database=CoreMvc;User Id=sa;Password=q1w2E#R$;TrustServerCertificate=True;MultipleActiveResultSets=true;"
    },
    "AllowedHosts": "*",
    "Upload": ["..", "Files", "Uploads"]
}
```

檔案的存取路徑從 AppDomain.CurrentDomain.BaseDirectory 開始 !

原則上就是放在網站資料夾的上一層的 /Files/Uploads

```cs
private void SaveFile(SampleDto dto)
{
    var pathParts = new List<string>();
    pathParts.Add(AppDomain.CurrentDomain.BaseDirectory);
    pathParts.AddRange(_appSettings.CurrentValue.Upload);

    var saveFolder = Path.Combine(pathParts.ToArray());
    if (!Directory.Exists(saveFolder)) Directory.CreateDirectory(saveFolder);

    var saveFileName = Path.GetRandomFileName();
    pathParts.Add(saveFileName);
    var saveFilePath = Path.Combine(pathParts.ToArray());

    var saveFileFullPath = Path.Combine(saveFilePath);
    _fileRepository.Save(saveFileFullPath, dto.File);
    dto.FileName     = dto.File.FileName;
    dto.SaveFileName = saveFileName;
}
```

Dockerfile

透過 VOLUMN [local_path] [container_path] 來指定掛載的對應 !

```dockerfile
# FROM [image] AS [stage]
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
# 接下來指令的工作目錄
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
# 指定後續指令之變數
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["AspNetCoreDocker/AspNetCoreDocker.csproj", "AspNetCoreDocker/"]
RUN dotnet restore "AspNetCoreDocker/AspNetCoreDocker.csproj"
COPY . .
WORKDIR "/src/AspNetCoreDocker"
# 帶入先前給定的變數
RUN dotnet build "AspNetCoreDocker.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "AspNetCoreDocker.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
VOLUME /Volumes/K_480G/Docker/Upload /app/Files
WORKDIR /app
# COPY --from=stage 為指定檔案複製來源的 stage
# 從 stage public 的 /app/publish 複製檔案到 .  ( 也就是 /app 中 )
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "AspNetCoreDocker.dll"]
```

docker-compose.yml

```yml
version: '3.9'
services:
    db:
        image: mcr.microsoft.com/mssql/server:2019-latest
        container_name: mssql
        volumes:
            - /Volumes/K_480G/Docker/CoreMvc/DB:/var/opt/mssql/data
        environment:
            - ACCEPT_EULA=Y
            - SA_PASSWORD=q1w2E#R$
    app:
        build:
            context: .
            dockerfile: Dockerfile
        ports:
            - 8000:80
        working_dir: /app
```
