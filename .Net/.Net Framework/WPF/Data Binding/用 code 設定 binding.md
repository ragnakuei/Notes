# 用 code 設定 binding

## 範例一：讓 user control width 與 window width 相同

```csharp
private void AddUserControlA()
{
    var userControlA = new UserControlA();

    var binding = new Binding()
    {
        Source = ViewClass,
        Path   = new PropertyPath(Window.WidthProperty),
        Mode   = BindingMode.OneWay
    };
    userControlA.SetBinding(UserControl.WidthProperty, binding);

    _userControlAViewModel = userControlA.DataContext as userControlAViewModel;
    gd_Content.Children.Add( userControlA );
}

/// <summary>
/// 對應的整個畫面view層
/// </summary>
private Window ViewClass
{
    get => ( CurrentWindowService as CurrentWindowService )?.ActualWindow as Window;
}
```