# ContextMenu

## 範例：以 Code 的方式宣告 ContextMenu

```xml
<TextBox
    x:Name="tbx"
    Width="200"
    Height="30"
    Text="right-click this textbox">
</TextBox>
```

```csharp
public Window1()
{
    InitializeComponent();

    var contextmenu = new ContextMenu();
    var mi = new MenuItem();
    mi.Header = "File";
    mi.Click += MenuItemOnClickFile;
    contextmenu.Items.Add(mi);

    tbx.ContextMenu = contextmenu;
}

private void MenuItemOnClickFile(object sender, RoutedEventArgs e)
{
    
}
```

