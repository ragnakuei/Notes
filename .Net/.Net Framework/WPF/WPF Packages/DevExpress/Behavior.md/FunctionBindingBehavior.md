- [FunctionBindingBehavior](#functionbindingbehavior)
  - [OneWay Binding](#oneway-binding)

# [FunctionBindingBehavior](https://documentation.devexpress.com/WPF/18128/MVVM-Framework/Behaviors/Predefined-Set/FunctionBindingBehavior)

- 將指定的控制項資料透過 ViewModel 指定的 Function 處理後，再放至另一個控制項內
- 用 GUI 設定會比較方便一些些
- 似乎不支援 TwoWay Binding (GUI 上無法設定 且 找不到相關 Sample)

---

## OneWay Binding

將 tbx2.Text 值加上 `Test:` 後，Binding 至 tbx1.Text

- 來源的指定

  - Source - 可直接指定 {Binding} 來 binding DataContext
  - Function - 當 Source 指定 DataContext 時，就可以在此處指定 DataContext 內的 public method
  - ArgX - 指定 Function 的引數來源，X = 1 ~ 15，代表最多可依序指定 15 個引數

- 套用值

  - Target - 套用值的對象，可以指到控制項
  - Property - 將值放到 Target 指定的 Property 中

- 宣告

  - 可以放在 tbx1、tbx2、Labe 內，但放在該 View 的控制項下會相對比較明確

```xml
<Window x:Class="WpfSample01.Samples.M.MView"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:local="clr-namespace:WpfSample01.Samples.M"
        xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
        mc:Ignorable="d"
        Title="MView" Height="450" Width="800">
    <Window.DataContext>
        <local:MViewModel />
    </Window.DataContext>
    <dxmvvm:Interaction.Behaviors>
        <dxmvvm:FunctionBindingBehavior Source="{Binding}"
                                        Function="Test"
                                        Arg1="{Binding Text, ElementName=tbx2}"

                                        Target="{Binding ElementName=tbx1, Mode=OneWay}"
                                        Property="Text" />
    </dxmvvm:Interaction.Behaviors>
    <StackPanel>
        <TextBox Name="tbx1" Text="" />
        <Label Content="從下將傳值至上" />
        <TextBox Name="tbx2" Text="" />
    </StackPanel>
</Window>
```

```csharp
public class MViewModel : ViewModelBase
{
    public string Test(string s)
    {
        return $"Test:{s}";
    }
}
```
