# [PowerShell](https://github.com/Microsoft/Docker-PowerShell/)

## 安裝

於 PowerShell 執行以下指令

- Register-PSRepository -Name DockerPS-Dev -SourceLocation https://ci.appveyor.com/nuget/docker-powershell-dev
- Install-Module -Name Docker -Repository DockerPS-Dev -Scope CurrentUser

> Get-Container

> Get-ContainerDetail ContainerName

> Get-ContainerImage [RepoTags]

> Get-ContainerNet

> Get-ContainerNetDetail DriverName
