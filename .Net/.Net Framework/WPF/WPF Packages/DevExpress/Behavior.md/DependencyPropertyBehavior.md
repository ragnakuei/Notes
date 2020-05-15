# [DependencyPropertyBehavior](https://documentation.devexpress.com/WPF/17373/MVVM-Framework/Behaviors/Predefined-Set/DependencyPropertyBehavior)

- [DependencyPropertyBehavior](#dependencypropertybehavior)
  - [TextBox.SelectedText](#textboxselectedtext)

讓 ViewModel 內的 Property 可以透過 Event 來 Binding 控制項內的 Property

用法

- PropertyName - 控制項內所指定的 Proprrty
- EventName - 觸發了哪個事件才會進行取值
- Binding - ViewModel Binding 的 Property

---

## TextBox.SelectedText

```xml
<UserControl x:Class="WpfApp7.Main.MainView"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
             xmlns:local="clr-namespace:WpfApp7.Main"
             xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
             xmlns:dxe="http://schemas.devexpress.com/winfx/2008/xaml/editors"
             xmlns:child="clr-namespace:WpfApp7.Child"
             DataContext="{dxmvvm:ViewModelSource Type=local:MainViewModel}"
             Name="LayoutRoot"
             mc:Ignorable="d" >
    <UserControl.Resources>
        <dxmvvm:BooleanToObjectConverter x:Key="BooleanToObjectConverterKey" TrueValue="Saved!" FalseValue="Unsaved!"/>
    </UserControl.Resources>
    <StackPanel>
        <TextBox Text="Select some text in this box">
            <dxmvvm:Interaction.Behaviors>
                <dxmvvm:DependencyPropertyBehavior PropertyName="SelectedText"
                                                   EventName="SelectionChanged"
                                                   Binding="{Binding SelectedTextZZ, Mode=TwoWay}"/>
            </dxmvvm:Interaction.Behaviors>
        </TextBox>
        <Button Content="Check" Command="{Binding CloseCommand}"/>
    </StackPanel>
</UserControl>
```

```csharp
[POCOViewModel(ImplementIDataErrorInfo = true)]
public class MainViewModel
{
    public string SelectedTextZZ { get; set; }

    public MainViewModel()
    {
        CloseCommand = new DelegateCommand(CloseCommandExecute);
    }

    public ICommand CloseCommand { get; private set; }

    private void CloseCommandExecute()
    {

    }
}
```
