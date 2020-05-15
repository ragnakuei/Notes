# [GridControl](https://documentation.devexpress.com/WPF/6084/Controls-and-Libraries/Data-Grid)

- [GridControl](#gridcontrol)
  - [範例一:ObservableCollection\<T>](#%e7%af%84%e4%be%8b%e4%b8%80observablecollectiont)
  - [範例二:List\<T>](#%e7%af%84%e4%be%8b%e4%ba%8clistt)
  - [TableView 停用最上方的 GroupPanel](#tableview-%e5%81%9c%e7%94%a8%e6%9c%80%e4%b8%8a%e6%96%b9%e7%9a%84-grouppanel)
  - [SelectedItem 語法](#selecteditem-%e8%aa%9e%e6%b3%95)

---

套件
> DevExpress.Xpf.Grid.v19.2
> DevExpress.Xpf.Grid.v19.2.Core
> DevExpress.Xpf.Grid.v19.2.Extensions

FilterString 的 Binding 需要以下𤨔境
  - ViewModel 只能用 ViewModelSource 的方式來達成，不能用 PocoModel，也不能用 ViewModelBase
  - Binding Property 都使用 virtual 宣告
  - [reference](https://github.com/DevExpress-Examples/how-to-use-enumitemssourcebehavior-t196946)


ItemsSource Binding 的 Property 如果要用 ObservableCollection\<T>，就必須只能在 ViewModel 建構子中初始化，而且之後無法變更。

如果要把上述的狀況改成可以動態變更的話，要把 ObservableCollection\<T> 改成 List\<T>，再透過 SetProperty() 的方式來變更。

重新給定 ItemsSource 後，CurrentItem 及 SelectedItem 都會被清空 !

---

## 範例一:ObservableCollection\<T>

ItemsSource 必須在 ViewModel 建構子給定，之後無法變更

```xml
<Window
    x:Class="WpfApp1.MainWindow"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
    xmlns:dxg="http://schemas.devexpress.com/winfx/2008/xaml/grid"
    xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
    xmlns:local="clr-namespace:WpfApp1"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    Title="MainWindow"
    Width="800"
    Height="450"
    mc:Ignorable="d">
    <Window.DataContext>
        <local:MainViewModel />
    </Window.DataContext>
    <StackPanel>
        <dxg:GridControl
            Height="600"
            AutoGenerateColumns="AddNew"
            ItemsSource="{Binding GridControlItemsSource}">
            <dxg:GridControl.View>
                <dxg:TableView />
            </dxg:GridControl.View>
            <dxg:GridControl.Columns>
                <dxg:GridColumn Width="1*" FieldName="Id" />
                <dxg:GridColumn Width="1*" FieldName="Name" />
            </dxg:GridControl.Columns>
        </dxg:GridControl>
    </StackPanel>
</Window>
```

```csharp
public class MainViewModel : ViewModelBase
{
    public MainViewModel()
    {
        LoadGridControlItemsSource();
    }

    private void LoadGridControlItemsSource()
    {
        GridControlItemsSource = new ObservableCollection<Test>
        {
            new Test { Id = 1, Name = "A"},
            new Test { Id = 2, Name = "B"},
            new Test { Id = 3, Name = "C"},
        };
    }

    public ObservableCollection<Test> GridControlItemsSource { get; set; }
}
```

## 範例二:List\<T>

可以在之後變更 ItemsSource 的內容

```xml
<Window
    x:Class="WpfApp1.MainWindow"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
    xmlns:dxg="http://schemas.devexpress.com/winfx/2008/xaml/grid"
    xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
    xmlns:local="clr-namespace:WpfApp1"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    Title="MainWindow"
    Width="800"
    Height="450"
    mc:Ignorable="d">
    <Window.DataContext>
        <local:MainViewModel />
    </Window.DataContext>
    <StackPanel>
        <Button Content="Bind Data">
            <dxmvvm:Interaction.Behaviors>
                <dxmvvm:EventToCommand Command="{Binding OnClickBindDataCommand}" EventName="Click" />
            </dxmvvm:Interaction.Behaviors>
        </Button>
        <dxg:GridControl
            Height="600"
            AutoGenerateColumns="AddNew"
            ItemsSource="{Binding GridControlItemsSource}">
            <dxg:GridControl.View>
                <dxg:TableView />
            </dxg:GridControl.View>
            <dxg:GridControl.Columns>
                <dxg:GridColumn Width="1*" FieldName="Id" />
                <dxg:GridColumn Width="1*" FieldName="Name" />
            </dxg:GridControl.Columns>
        </dxg:GridControl>
    </StackPanel>
</Window>
```

```csharp
public class MainViewModel : ViewModelBase
{
    public MainViewModel()
    {
        OnClickBindDataCommand = new DelegateCommand(OnClickBindDataExecute);
    }

    private void LoadGridControlItemsSource()
    {
        GridControlItemsSource = new List<Test>
        {
            new Test { Id = 1, Name = "A"},
            new Test { Id = 2, Name = "B"},
            new Test { Id = 3, Name = "C"},
        };
    }

    public ICommand OnClickBindDataCommand { get; }

    private void OnClickBindDataExecute()
    {
        LoadGridControlItemsSource();
    }

    private List<Test> _gridControlItemsSource;

    public List<Test> GridControlItemsSource
    {
        get => _gridControlItemsSource;
        set {
            SetProperty(ref _gridControlItemsSource, value, nameof(GridControlItemsSource));
        }
    }
}
```

---

## TableView 停用最上方的 GroupPanel

在指定 TableView 時，給定以下 Property 值

```xml
ShowGroupPanel="False"
```

---

## SelectedItem 語法

重新給定 ItemsSource 後，CurrentItem 及 SelectedItem 都會被清空 !

```xml
<dxg:GridControl
    Height="600"
    AutoGenerateColumns="AddNew"
    CurrentItem="{Binding GridControlCurrentItem}"
    ItemsSource="{Binding GridControlItemsSource}"
    SelectedItem="{Binding GridControlSelectedItem}">
    <dxg:GridControl.View>
        <dxg:TableView/>
    </dxg:GridControl.View>
    <dxg:GridControl.Columns>
        <dxg:GridColumn Width="1*" FieldName="Id" />
        <dxg:GridColumn Width="1*" FieldName="Name" />
    </dxg:GridControl.Columns>
</dxg:GridControl>
```