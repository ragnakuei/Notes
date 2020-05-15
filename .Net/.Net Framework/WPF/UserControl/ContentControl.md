# ContentControl

## 用法一

- 做單一 Object 的綁定
- 必須要額外指定 DataTemplate 並且指向該 Template

```xml
<Window x:Class="WpfApp6.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp6"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Window.DataContext>
        <local:MainViewModel />
    </Window.DataContext>
    <StackPanel>
        <StackPanel.Resources>
            <DataTemplate x:Key="SampleTemplate">
                <StackPanel>
                    <TextBlock Text="{Binding Path = OrderId}" />
                    <TextBlock Text="{Binding Name}" />
                </StackPanel>
            </DataTemplate>
        </StackPanel.Resources>
        <ContentControl Content="{Binding Order}" ContentTemplate="{StaticResource SampleTemplate}" />
    </StackPanel>
</Window>
```

## 用法二

可用來 Binding UserControl ViewModel

當 Binding ViewModelBase 時，就會參考 View Resource DataTemplate 所對應的 DataType

進而顯示對應的 View

```csharp

// ViewModelBase 來源是 MvvmLight 元件
public class MainWindowViewModel : ViewModelBase
{
    private readonly DiFactory _diFactory;
    private readonly MainViewModel _mainViewModel;
    private readonly MainView _mainView;
    private ViewModelBase _content;

    public ViewModelBase Content
    {
        get => _content;
        set => Set(ref _content, value);
    }

    public MainWindowViewModel(DiFactory diFactory)
    {
        _diFactory = diFactory;
        
        _mainView = _diFactory.GetService<MainView>();
        _mainViewModel = _diFactory.GetService<MainViewModel>();
        _mainView.DataContext = _mainViewModel;
        
        Content = _mainViewModel;
    }
}
```

```xml
<Window x:Class="WpfApp2.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp2"
        xmlns:view="clr-namespace:WpfApp2.View"
        xmlns:viewModel="clr-namespace:WpfApp2.ViewModel"
        d:DataContext="{d:DesignInstance local:MainWindowViewModel,
                                         IsDesignTimeCreatable=True}"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Window.Resources>
        <DataTemplate DataType="{x:Type viewModel:MainViewModel}">
            <view:MainView />
        </DataTemplate>
    </Window.Resources>
    <StackPanel>
        <ContentControl Content="{Binding Content}" />
    </StackPanel>
</Window>
```
