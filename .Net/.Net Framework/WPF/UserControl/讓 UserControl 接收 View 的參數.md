# 讓 UserControl 接收 View 的參數

透過 TextBox.Text 將值傳入 UserControl 中

```xml
<StackPanel>
    <Label>EView</Label>
    <TextBox Name="TextBox1"></TextBox>
    <subUserControl:ESubUserControl1 UserName="{Binding Path=Text, ElementName=TextBox1, Mode=OneWay}" />
</StackPanel>
```

主要是 Accessor 都是靠 DependencyProperty 來處理的

```csharp
public partial class ESubUserControl1 : UserControl
{
    public ESubUserControl1()
    {
        InitializeComponent();
    }

    public string UserName
    {
        get { return (string)GetValue(UserNameProperty); }
        set { SetValue(UserNameProperty, value); }
    }

    public static readonly DependencyProperty UserNameProperty =
        DependencyProperty.Register("UserName"
                                    , typeof(string)
                                    , typeof(ESubUserControl1)
                                    , new UIPropertyMetadata(default(string)));


    private void ButtonBase_OnClick(object sender, RoutedEventArgs e)
    {
        MessageBox.Show("Click");
    }
}
```
