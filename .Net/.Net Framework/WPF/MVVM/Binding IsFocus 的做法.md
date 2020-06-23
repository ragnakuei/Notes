# Binding IsFocus 的做法

### 先建立對應的 Helper

```csharp
public static class FocusHelper
{
    public static bool GetIsFocused(DependencyObject obj)
    {
        return (bool)obj.GetValue(IsFocusedProperty);
    }

    public static void SetIsFocused(DependencyObject obj, bool value)
    {
        obj.SetValue(IsFocusedProperty, value);
    }

    public static readonly DependencyProperty IsFocusedProperty =
        DependencyProperty.RegisterAttached("IsFocused"
                                            , typeof(bool)
                                            , typeof(FocusHelper)
                                            , new UIPropertyMetadata(false, OnIsFocusedPropertyChanged));

    private static void OnIsFocusedPropertyChanged(DependencyObject                   d,
                                                    DependencyPropertyChangedEventArgs e)
    {
        var uie = (UIElement)d;
        if ((bool)e.NewValue)
        {
            uie.Focus(); // Don't care about false values.
        }
    }
}
```

### 套用至 View 上

```xml
<dx:SimpleButton Content="Apply" helpers:FocusHelper.IsFocused="{Binding IsApplyButtonFocused}">
    <dxmvvm:Interaction.Behaviors>
        <dxmvvm:EventToCommand Command="{Binding OnClickApplyCommand}" EventName="Click" />
    </dxmvvm:Interaction.Behaviors>
</dx:SimpleButton>
```

### 套用至 ViewModel 上

如果未先給定 focus = false 的話，之後重新 focus 時，游標就不會 focus 至指定的地方

```csharp
private bool _isApplyButtonFocused;

public bool IsApplyButtonFocused
{
    get => _isApplyButtonFocused;
    set => SetProperty(ref _isApplyButtonFocused, value, nameof(IsApplyButtonFocused));
}

public void Run()
{
    IsApplyButtonFocused = false;
    IsApplyButtonFocused = true;
}
```
