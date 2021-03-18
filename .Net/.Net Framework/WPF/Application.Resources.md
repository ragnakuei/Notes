# Application.Resources

在 App.xaml 中可以把以下內容加到 \<Application.Resources></Application.Resources> 中

> Key 是 headerTextStyle

```xml
<Style x:Key="headerTextStyle">
    <Setter Property="Label.VerticalAlignment" Value="Center"></Setter>
    <Setter Property="Label.FontFamily" Value="Trebuchet MS"></Setter>
    <Setter Property="Label.FontWeight" Value="Bold"></Setter>
    <Setter Property="Label.FontSize" Value="18"></Setter>
    <Setter Property="Label.Foreground" Value="#0066cc"></Setter>
</Style>
```

就可以以下面的方式來套用上面的 Style

> 注意一下 Style 是如何給定 Key 值

```xml
<Label Grid.Column="1" Style="{StaticResource headerTextStyle}" >
    View Expense Report
</Label>
```
