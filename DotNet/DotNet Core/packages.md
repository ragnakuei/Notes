# packages

1. 透過 Visual Studio、Rider IDE 管理
2. 透過 cli 管理

   - Visual Studio - Package Manage Console - [於 PowerShell 下操作](https://docs.microsoft.com/zh-tw/nuget/reference/powershell-reference)

     | 指令                                             | 說明                   |
     | ------------------------------------------------ | ---------------------- |
     | Install-Package [PackageName]                    |                        |
     | Install-Package [PackageName] -Version [Version] | 安裝指定版本套件       |
     | Install-Package [PackageName] -Source [Source]   | 從指定 Source 安裝套件 |
     | Update-Package [PackageName]                     |                        |
     | Update-Package [PackageName] -Version [Version]  |                        |
     | Update-Package [PackageName] -Source [Source]    | 從指定 Source 更新套件 |
     | Uninstall-Package [PackageName]                  |                        |

   - [.Net Cli](https://docs.microsoft.com/zh-tw/dotnet/core/tools/dotnet-add-package)

     | 指令                                          | 說明                   |
     | --------------------------------------------- | ---------------------- |
     | dotnet add package [PackageName]              |                        |
     | dotnet add package [PackageName] -v [Version] | 安裝指定版本套件       |
     | dotnet add package [PackageName] -s [Source]  | 從指定 Source 安裝套件 |
     | dotnet remove package [PackageName]           |                        |
