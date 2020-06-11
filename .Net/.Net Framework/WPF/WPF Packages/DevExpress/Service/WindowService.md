# WindowService

- [WindowService](#windowservice)
  - [範例：指定開啟一個 View](#範例指定開啟一個-view)
  - [範例：選擇開啟一個 View](#範例選擇開啟一個-view)
  - [範例：程式內給定 Window Style](#範例程式內給定-window-style)

---

把 UserControl View 以 Window 方式呈現

- 被開啟的 View，一定不能是 Window
- 如果直接在宣告 WindowService 時，就給定指定的 View，那就無法選擇要開啟第二個 userControl
- 透過 WindowService 開啟的 View 中，同時只開啟一個，無法同時開啟第二個
- 當 View 以 Window 方式呈現時，該 View/ViewModel 可以透過 ICurrentWindowService 來做 Close() 的動作

---

## 範例：指定開啟一個 View

開啟指定的 View

```xml
<UserControl x:Class="WpfAppTest01.Views.MainView"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
             xmlns:local="clr-namespace:WpfAppTest01.Views"
             xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
             xmlns:viewModels="clr-namespace:WpfAppTest01.ViewModels"
             mc:Ignorable="d"
             d:DesignHeight="300" d:DesignWidth="300">
    <UserControl.DataContext>
        <viewModels:MainViewModel/>
    </UserControl.DataContext>
    <dxmvvm:Interaction.Behaviors>
        <dxmvvm:WindowService>
            <dxmvvm:WindowService.ViewTemplate>
                <DataTemplate>
                    <local:ViewA />
                </DataTemplate>
            </dxmvvm:WindowService.ViewTemplate>
            <!--<dxmvvm:WindowService.WindowStyle>
                    <Style TargetType="dx:ThemedWindow">
                        <Setter Property="Width" Value="500" />
                        <Setter Property="Height" Value="300" />
                        <Setter Property="Title" Value="{Binding Caption}" />
                        <Setter Property="WindowState" Value="{Binding WindowState}" />
                    </Style>
                </dxmvvm:WindowService.WindowStyle>-->
        </dxmvvm:WindowService>
    </dxmvvm:Interaction.Behaviors>
    <StackPanel>
        <Button Content="Open WindowA">
            <dxmvvm:Interaction.Behaviors>
                <dxmvvm:EventToCommand Command="{Binding OpenWindowACommand}" EventName="Click" />
            </dxmvvm:Interaction.Behaviors>
        </Button>
    </StackPanel>
</UserControl>
```

```csharp
public class MainViewModel : ViewModelBase
{
    public MainViewModel()
    {
        OpenWindowACommand = new DelegateCommand( OpenWindowAExecute );
    }

    protected IWindowService WindowService => this.GetService<IWindowService>();
    
    public ICommand OpenWindowACommand { get; }

    private void OpenWindowAExecute()
    {
        var windowAViewModel = new WindowAViewModel();
        WindowService.Show(nameof(ViewA), windowAViewModel);
    }
}
```

---

## 範例：選擇開啟一個 View

可以從多個 View 中，選擇一個來開啟

```xml
<UserControl x:Class="WpfAppTest01.Views.MainView"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
             xmlns:local="clr-namespace:WpfAppTest01.Views"
             xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
             xmlns:viewModels="clr-namespace:WpfAppTest01.ViewModels"
             mc:Ignorable="d"
             d:DesignHeight="300" d:DesignWidth="300">
    <UserControl.DataContext>
        <viewModels:MainViewModel/>
    </UserControl.DataContext>
    <dxmvvm:Interaction.Behaviors>
        <dxmvvm:WindowService />
    </dxmvvm:Interaction.Behaviors>
    <StackPanel>
        <Button Content="Open WindowA">
            <dxmvvm:Interaction.Behaviors>
                <dxmvvm:EventToCommand Command="{Binding OpenWindowACommand}" EventName="Click" />
            </dxmvvm:Interaction.Behaviors>
        </Button>
        <Button Content="Open WindowB">
            <dxmvvm:Interaction.Behaviors>
                <dxmvvm:EventToCommand Command="{Binding OpenWindowBCommand}" EventName="Click" />
            </dxmvvm:Interaction.Behaviors>    
        </Button>
    </StackPanel>
</UserControl>

```

```csharp
public class MainViewModel : ViewModelBase
{
    public MainViewModel()
    {
        OpenWindowACommand = new DelegateCommand( OpenWindowAExecute );
        OpenWindowBCommand = new DelegateCommand( OpenWindowBExecute );
    }

    protected IWindowService WindowService => this.GetService<IWindowService>();
    
    public ICommand OpenWindowACommand { get; }

    private void OpenWindowAExecute()
    {
        var windowAViewModel = new WindowAViewModel();
        WindowService.Show(nameof(ViewA), windowAViewModel);
    }
    public ICommand OpenWindowBCommand { get; }

    private void OpenWindowBExecute()
    {
        var windowBViewModel = new WindowBViewModel();
        WindowService.Show(nameof(ViewB), windowBViewModel);
    }
}
```

## 範例：程式內給定 Window Style

```csharp
AboutViewModel viewModel = new AboutViewModel();

if (WindowService is WindowService windowService)
{
    windowService.WindowShowMode = WindowShowMode.Dialog;
    Style windowStyle = new Style
                        {
                            TargetType = typeof(ThemedWindow),
                            Setters =
                            {
                                new Setter(ThemedWindow.WidthProperty,      (double)600),
                                new Setter(ThemedWindow.HeightProperty,     (double)300),
                                new Setter(ThemedWindow.TitleProperty,      "About"),
                                new Setter(ThemedWindow.ResizeModeProperty, ResizeMode.NoResize),
                            }
                        };

    windowService.WindowStyle = windowStyle;
}

WindowService.Show(nameof(AboutView), viewModel);
```

