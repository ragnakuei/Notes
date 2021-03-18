# [Startup](https://docs.microsoft.com/en-us/dotnet/api/system.windows.application.startup)

## 方式一：手動指定

```csharp
void App_Startup(object sender, StartupEventArgs e) 
{ 
    // 擴充功能寫在這
}
```

```xml
<Application x:Class="WpfApp.App"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:local="clr-namespace:WpfApp"
             StartupUri="MainWindow.xaml"
             Startup="Application_Startup">
    <Application.Resources></Application.Resources>
</Application>
```

## 方式二：擴充

App.xaml 不用修改

直接改 App.xaml.cs 就可以了

```csharp
public partial class App : Application
{
    protected override void OnStartup(StartupEventArgs e)
    {
        base.OnStartup(e);

        // 擴充功能寫在這

    }
}
```
