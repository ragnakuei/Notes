# [ViewModelBase](https://documentation.devexpress.com/WPF/17446/MVVM-Framework/Services/Services-in-ViewModelBase-descendants)

- 手動引用 `DevExpress.Mvvm`
- 提供以下 Method
  - GetProperty()
  - SetProperty()
  - RaisePropertyChanged()
  - RaisePropertiesChanged()
- Initialize properties separately for runtime and design-time modes
  - OnInitializeInDesignMode() - 用於給 .Designer.cs 時顯示預覽用
  - OnInitializeInRuntime() - 執行時會執行的地方
- [Access Services registered within a View](##GetService\<T>())
- [Use View Model parent-child relationships](ParentViewModel.md)
- [Pass data between View Models](更新%20ViewModel%20後的重新%20Binding%20至%20View%20的方式.md)
- Create Commands without command properties

## GetService\<T>()

用來 Inject 指定的 instance

1. 在 View 裡宣告要 Inject 的 interface
1. 在 View 裡宣告要 使用的 ViewModel

```xml
<UserControl x:Class="WpfApp1.Views.DocumentView"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
             xmlns:viewModels="clr-namespace:WpfApp1.ViewModels">
    <!-- 此 View DataContext 的 Model  -->
    <UserControl.DataContext>
        <viewModels:DocumentViewModel />
    </UserControl.DataContext>
    <!-- 要 Inject 至 ViewModel 的 Service -->
    <dxmvvm:Interaction.Behaviors>
        <dxmvvm:CurrentWindowService />
    </dxmvvm:Interaction.Behaviors>
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition/>
            <RowDefinition/>
        </Grid.RowDefinitions>
        <Button Content="Close Document" Grid.Row="0" Command="{Binding CloseDocumentCommand}" />
        <Button Content="Close Window" Grid.Row="1" Command="{Binding CloseWindowCommand}" />
    </Grid>
</UserControl>
```

ViewModel

1. 繼承 ViewModelBase
1. 在 Constructor 宣告要使用的 Command
1. 讓 Accessor 來取出要 Injection instance
   > 注意:不要直接宣告初始值，也不要透過建構子取出 instance。

```csharp
public class DocumentViewModel : ViewModelBase
{
    public ICommand CloseWindowCommand { get; }

    protected ICurrentWindowService CurrentWindowService
    {
        get => this.GetService<ICurrentWindowService>();
    }

    public DocumentViewModel()
    {
        CloseWindowCommand = new DelegateCommand(CloseWindow);
    }

    void CloseWindow()
    {
        MessageBox.Show("Close Window");
        CurrentWindowService.Close();
    }
}
```
