# [Application](https://docs.microsoft.com/zh-tw/dotnet/api/system.windows.application)

[Application Overview](https://docs.microsoft.com/en-us/dotnet/framework/wpf/app-development/application-management-overview)

```xml
<Application x:Class="WpfApp.App"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:local="clr-namespace:WpfApp"
             Startup="Application_Startup"
             StartupUri="MainWindow.xaml">
    <Application.Resources></Application.Resources>
</Application>
```

Application 就是程式進入的點

- x:Class="WpfApp.App" 定義了實作 Application 的 Class
- Startup 程式啟動時的 Event
- StartupUri 程式啟動後的下一個執行點
