# Enviromnent Variables 環境變數

## IWebHostEnvironment

- 透過 DI 注入 IWebHostEnvironment
- ApplicationName - 專案名稱
- EnvironmentName - 環境變數
  - 對應至 ASPNETCORE_ENVIRONMENT 的設定
  - 一個 launchSettings.json 的一個 Profile，可以設定一個 ASPNETCORE_ENVIRONMENT
  - 對應至 appsettings.xxx.json，其中的 xxx 就是 ASPNETCORE_ENVIRONMENT 所設定的


## GetEnvironmentVariable()

1. 存放環境變數

    在專案 > Properties > launchSettings.json 的 environmentVariables 物件內

    ```json
    {
      "profiles": {
        "ConsoleApp1": {
          "commandName": "Project",
          "environmentVariables": {
            "Test": "A"
          }
        }
      }
    }
    ```

1. 取出環境變數

    ```csharp
    Environment.GetEnvironmentVariable("Test")
    ```

    就可以取出環境變數中的值

