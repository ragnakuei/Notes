# [StartupUri](https://docs.microsoft.com/zh-tw/dotnet/api/system.windows.application.startupuri)

如果不指定 StartupUri 的 Window

可以在 Startup Event 手動執行 Window

```xml
<Application x:Class="WpfApp2.App"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:local="clr-namespace:WpfApp2"
             Startup="Application_Startup" >
</Application>
```

```csharp
public partial class App : Application
{
    private void Application_Startup(object sender, StartupEventArgs e)
    {
        var mainWindow = new MainWindow();
        MainWindow.Show();
    }
}
```

跟下面的效果相同

```xml
<Application x:Class="WpfApp2.App"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:local="clr-namespace:WpfApp2"
             StartupUri="MainWindow.xaml">
</Application>
```