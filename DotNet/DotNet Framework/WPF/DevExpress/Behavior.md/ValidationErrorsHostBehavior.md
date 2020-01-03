# [ValidationErrorsHostBehavior](https://documentation.devexpress.com/WPF/17371/MVVM-Framework/Behaviors/Predefined-Set/ValidationErrorsHostBehavior)

- [ValidationErrorsHostBehavior](#validationerrorshostbehavior)
  - [當符合所有驗正條件後，Button 才會 Enable (POCO)](#%e7%95%b6%e7%ac%a6%e5%90%88%e6%89%80%e6%9c%89%e9%a9%97%e6%ad%a3%e6%a2%9d%e4%bb%b6%e5%be%8cbutton-%e6%89%8d%e6%9c%83-enable-poco)
  - [當符合所有驗正條件後，Button 才會 Enable (ViewModelBase)](#%e7%95%b6%e7%ac%a6%e5%90%88%e6%89%80%e6%9c%89%e9%a9%97%e6%ad%a3%e6%a2%9d%e4%bb%b6%e5%be%8cbutton-%e6%89%8d%e6%9c%83-enable-viewmodelbase)

- 一定要用 DevExpress 所提供的 Control

---

## 當符合所有驗正條件後，Button 才會 Enable (POCO)

當 Id 有資料後，Button 才會 Enable

缺點

- ViewModel 同時負責了 資料驗証 及 Event 邏輯

```xml
<UserControl x:Class="WpfApp7.Main.MainView"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
             xmlns:local="clr-namespace:WpfApp7.Main"
             xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
             xmlns:dxe="http://schemas.devexpress.com/winfx/2008/xaml/editors"
             DataContext="{dxmvvm:ViewModelSource Type=local:MainViewModel}"
             mc:Ignorable="d" >
    <dxmvvm:Interaction.Behaviors>
        <dxmvvm:ValidationErrorsHostBehavior x:Name="validServ"/>
    </dxmvvm:Interaction.Behaviors>
    <!-- 不可使用下面這種語法來指定 DataContext -->
    <!--<UserControl.DataContext>
        <local:MainViewModel/>
    </UserControl.DataContext>-->
    <StackPanel>
        <dxe:TextEdit Text="{Binding Id,
                        ValidatesOnDataErrors=True,
                        UpdateSourceTrigger=PropertyChanged,
                        NotifyOnSourceUpdated=True,
                        NotifyOnValidationError=True }"/>
        <Button Content="Save"
                Command="{Binding SaveConfirmCommand}"
                IsEnabled="{Binding ElementName=validServ,
                            Path=HasErrors,
                            Converter={dxmvvm:BooleanNegationConverter}}"/>
    </StackPanel>
</UserControl>

```

```csharp
[POCOViewModel(ImplementIDataErrorInfo = true)]
public class MainViewModel
{
    [Required]
    public string Id { get; set; }

    public MainViewModel()
    {
        SaveConfirmCommand = new DelegateCommand(SaveConfirmCommandExecute);
    }
    public ICommand SaveConfirmCommand { get; private set; }

    private void SaveConfirmCommandExecute()
    {

    }
}
```

---

## 當符合所有驗正條件後，Button 才會 Enable (ViewModelBase)

[不支援此功能](https://www.devexpress.com/Support/Center/Question/Details/T316059/viewmodel-and-idataerrorinfo)

> 1\) ViewModelBase does not implement the IDataErrorInfo interface
