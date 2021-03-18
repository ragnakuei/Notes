# DI

> 讓 View 在指定 ViewModel 時，仍使用無參數建構子的方式 !

> ViewModel 內仍以 DiFactory.GetService<T>() 的方式來建立 intance

## 範例

### 建立 DiFactory

```csharp
public class DiFactory
{
    private static readonly ServiceProvider _serviceProvider;

    static DiFactory()
    {
        var services = new ServiceCollection();
        services.AddSingleton<DiFactory>();
        services.AddTransient<MainWindow>();
        services.AddTransient<MainWindowViewModel>();

        services.AddTransient<MainView>();
        services.AddTransient<MainViewModel>();

        _serviceProvider = services.BuildServiceProvider();
    }

    public T GetService<T>()
    {
        return _serviceProvider.GetService<T>();
    }

    public (TUserControl UserControl, TViewModelBase ViewModel) GetUserControlWithViewMode<TUserControl, TViewModelBase>()
        where TUserControl : UserControl
        where TViewModelBase : ViewModelBase
    {
        var view = GetService<TUserControl>();
        var viewModel = GetService<TViewModelBase>();
        view.DataContext = viewModel;
        return (view, viewModel);
    }
    
    public (TWindow Window, TViewModelBase ViewModel) GetWindowithViewMode<TWindow, TViewModelBase>()
        where TWindow : Window
        where TViewModelBase : ViewModelBase
    {
        var view = GetService<TWindow>();
        var viewModel = GetService<TViewModelBase>();
        view.DataContext = viewModel;
        return (view, viewModel);
    }
}
```

### 刪除 App.xaml 的 StartupUri 所指定的 Url

StartupUri 所指定的 View 會從 App.xaml.cs 來指定

### 套用至 App.xaml.cs 中

```csharp
public partial class App : Application
{
    protected override void OnStartup(StartupEventArgs e)
    {
        base.OnStartup(e);

        var diFactory = new DiFactory();
        var mainView = diFactory.GetWindowithViewMode<MainWindow, MainWindowViewModel>();
        mainView.Window.ShowDialog();
    }
}
```