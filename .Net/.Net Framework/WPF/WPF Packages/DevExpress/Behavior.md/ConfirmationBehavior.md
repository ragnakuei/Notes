# [ConfirmationBehavior](https://documentation.devexpress.com/WPF/17372/MVVM-Framework/Behaviors/Predefined-Set/ConfirmationBehavior)

- 觸發時，綁定的值是 false，就會跳出 `是/否 對話框`
  - 選擇 `是` 之後，才會進入到 Command
  - 選擇 `否` 之後，不會進入到 Command
- 以下 Property 可以進行調整
  - MessageTitle 
  - MessageText
  - MessageIcon
  - MessageButton 
  - MessageDefaultResult 
  - MessageBoxService - 可給定自訂的 MessageBoxService

```xml
<UserControl x:Class="WpfApp7.Main.MainView"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
             xmlns:local="clr-namespace:WpfApp7.Main"
             xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
             DataContext="{dxmvvm:ViewModelSource Type=local:MainViewModel}"
             Name="LayoutRoot"
             mc:Ignorable="d" >
    <UserControl.Resources>
        <dxmvvm:BooleanToObjectConverter x:Key="BooleanToObjectConverterKey" TrueValue="Saved!" FalseValue="Unsaved!"/>
    </UserControl.Resources>
    <StackPanel>
        <Button Content="Close">
            <dxmvvm:Interaction.Behaviors>
                <dxmvvm:ConfirmationBehavior EnableConfirmationMessage="{Binding IsSaved, Converter={StaticResource BooleanToObjectConverterKey}}"
                                             Command="{Binding CloseCommand}"
                                             MessageText="Are you sure to close the unsaved document?"/>
            </dxmvvm:Interaction.Behaviors>
        </Button>
    </StackPanel>
</UserControl>
```

```csharp
[POCOViewModel(ImplementIDataErrorInfo = true)]
public class MainViewModel
{
    [Required]
    public string Id { get; set; }

    public bool IsSaved { get; set; } = false;

    public MainViewModel()
    {
        SaveConfirmCommand = new DelegateCommand(SaveConfirmCommandExecute);
        CloseCommand = new DelegateCommand(CloseCommandExecute);
        Child = new ChildViewModel();
    }

    public ChildViewModel Child{ get; set; }

    public ICommand SaveConfirmCommand { get; private set; }

    private void SaveConfirmCommandExecute()
    {

    }

    public ICommand CloseCommand { get; private set; }

    private void CloseCommandExecute()
    {

    }
}
```
