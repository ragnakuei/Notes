# StackPanel

- HorizontalAlignment - 設定成 Center 可以將控制項水平置中，而且會把裡面的控制項多餘的空白去掉
- VerticalAlignment - 設定成 Center 可以將控制項垂直置中

```xml
<StackPanel HorizontalAlignment="Center"
            VerticalAlignment="Center">
    <ContentControl Content="{Binding Content}" />
</StackPanel>
```
