# wpf 範例

## 安裝套件

> Install-Package NLog

## 設定 NLog


```csharp
public partial class App : Application
{
    protected override void OnStartup(StartupEventArgs e)
    {
        base.OnStartup(e);
        ConfigureNLog();
    }

    private static void ConfigureNLog()
    {
        // 手動設定 NLog 設定，就不透過 NLog.xsd
        var config = new NLog.Config.LoggingConfiguration();

        var logfile = new NLog.Targets.FileTarget("logfile") { FileName = "logs/file.txt" };
        config.AddRule(LogLevel.Debug, LogLevel.Fatal, logfile);

        // 增加 Console Rule
        // var logconsole = new NLog.Targets.ConsoleTarget("logconsole");
        // config.AddRule(LogLevel.Info, LogLevel.Fatal, logconsole);

        // Apply config           
        NLog.LogManager.Configuration = config;
    }
}
```

## 程式呼叫

```csharp
public partial class MainWindow : Window
{
    private static readonly ILogger Logger = LogManager.GetCurrentClassLogger();


    public MainWindow()
    {
        InitializeComponent();
    }

    private void OnClickA(object sender, RoutedEventArgs e)
    {
        Logger.Debug("A");
    }

    private void OnClickB(object sender, RoutedEventArgs e)
    {
        Logger.Debug("B");
    }
}
```