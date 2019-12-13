# [Startup](https://docs.microsoft.com/en-us/dotnet/api/system.windows.application.startup)

```csharp
void App_Startup(object sender, StartupEventArgs e) { }
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
