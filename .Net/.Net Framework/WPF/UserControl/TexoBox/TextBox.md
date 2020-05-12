# TextBox

[How to: Control When the TextBox Text Updates the Source](https://docs.microsoft.com/en-us/dotnet/framework/wpf/data/how-to-control-when-the-textbox-text-updates-the-source)

- TextBox.Text 預設以 `LostFocus` 來做為 `UpdateSourceTrigger` 的動作

---

## Validation

- 顯示的錯誤訊息會在 TextBox 左方

```xml
<Window x:Class="WpfApp3.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp3"
        xmlns:dx="http://schemas.devexpress.com/winfx/2008/xaml/core"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Window.Resources>
       <!-- 驗証失敗時的文字格式 -->
        <ControlTemplate x:Key="validationTemplate">
            <DockPanel>
                <TextBlock Foreground="Red" FontSize="20">!</TextBlock>
                <AdornedElementPlaceholder/>
            </DockPanel>
        </ControlTemplate>
        <Style x:Key="textBoxInError" TargetType="{x:Type TextBox}">
            <!-- 設定 TextBox 的 Trigger -->
            <Style.Triggers>
                <!-- 當 Validation.HasError = true 時，，就設定 ToolTip -->
                <Trigger Property="Validation.HasError" Value="true">
                    <Setter Property="ToolTip"
                            Value="{Binding RelativeSource={x:Static RelativeSource.Self},
                                   Path=(Validation.Errors)/ErrorContent}"/>
                </Trigger>
            </Style.Triggers>
        </Style>
        <local:Person x:Key="ods" Age="18"/>
    </Window.Resources>
    <Window.DataContext>
        <local:MainViewModel />
    </Window.DataContext>
    <StackPanel>
        <TextBox Name="textBox1" Width="50" FontSize="15"
         Validation.ErrorTemplate="{StaticResource validationTemplate}"
         Style="{StaticResource textBoxInError}"
         Grid.Row="1" Grid.Column="1" Margin="2">
            <TextBox.Text>
                <Binding Path="Age" Source="{StaticResource ods}" UpdateSourceTrigger="PropertyChanged" >
                    <Binding.ValidationRules>
                        <local:AgeRangeRule Min="21" Max="130"/>
                    </Binding.ValidationRules>
                </Binding>
            </TextBox.Text>
        </TextBox>
    </StackPanel>
</Window>

```

## Custom Validation

```xml
<Window x:Class="WpfApp3.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp3"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">

    <Window.Resources>
        <local:Person x:Key="data"/>
        <Style x:Key="textBoxInError" TargetType="TextBox">
            <Style.Triggers>
                <Trigger Property="Validation.HasError" Value="true">
                    <Setter Property="ToolTip"
                            Value="{Binding RelativeSource={x:Static RelativeSource.Self},
                            Path=(Validation.Errors)[0].ErrorContent}"/>
                </Trigger>
            </Style.Triggers>
        </Style>
    </Window.Resources>

    <StackPanel Margin="20">
        <TextBlock>Enter your age:</TextBlock>

        <TextBox Style="{StaticResource textBoxInError}">
            <TextBox.Text>
                <Binding Path="Age" Source="{StaticResource data}"
                         ValidatesOnExceptions="True"
                         UpdateSourceTrigger="PropertyChanged">
                    <Binding.ValidationRules>
                        <!-- 要加上下面這行，才會呼叫 IDataErrorInfo 的實作驗証 -->
                        <DataErrorValidationRule/>
                    </Binding.ValidationRules>
                </Binding>
            </TextBox.Text>
        </TextBox>

        <TextBlock>Mouse-over to see the validation error message.</TextBlock>
    </StackPanel>
</Window>

```

- 讓 Model 實作 IDataErrorInfo
  - string this[string name] - 實作各個 Property 的驗証邏輯
  - string Error

```csharp
 public class Person : IDataErrorInfo
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string HomeTown { get; set; }

    private int _age;

    public int Age
    {
        get { return _age; }
        set { _age = value; }
    }

    public string Error
    {
        get {
            return null;
        }
    }

    public string this[string name]
    {
        get {
            string result = null;

            if (name == "Age")
            {
                if (this.Age < 0 || this.Age > 150)
                {
                    result = "Age must not be less than 0 or greater than 150.";
                }
            }
            return result;
        }
    }
}
```
