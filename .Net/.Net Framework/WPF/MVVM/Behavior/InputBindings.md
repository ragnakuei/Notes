# InputBindings

當按下 Enter 時，將 Element Name 為 UserName 的 Text 值傳至 TextBoxInputCommand 的 Exector 中

```xml
<TextBox Name="UserName">
    <TextBox.InputBindings>
        <KeyBinding
            Command="{Binding Path=TextBoxInputCommand}"
            CommandParameter="{Binding Path=Text, ElementName=UserName}"
            Key="Enter" />
    </TextBox.InputBindings>
</TextBox>
```

```csharp
public EViewModel()
{
    OnLoadedCommand = new DelegateCommand(OnLoadedCommandExecute, OnLoadedCommandCanEnable);
    TextBoxInputCommand = new DelegateCommand<string>(TextBoxInputCommandExecute, TextBoxInputCommandCanEnable);
}

public ICommand<string> TextBoxInputCommand { get; private set; }

private void TextBoxInputCommandExecute(string value)
{
    _childUserControlViewModel.UserName = value;
}

private bool TextBoxInputCommandCanEnable(string value)
{
    return true;
}
```