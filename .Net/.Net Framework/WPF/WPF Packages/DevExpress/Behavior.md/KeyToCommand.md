# [KeyToCommand](https://documentation.devexpress.com/WPF/113865/MVVM-Framework/Behaviors/Predefined-Set/KeyToCommand)

-   透過鍵盤的熱鍵來觸發 Event

```xml
 <dxmvvm:Interaction.Behaviors>
    <dxmvvm:KeyToCommand KeyGesture="Ctrl+Enter" Command="{Binding EditCommand}" CommandParameter="{Binding ElementName=list, Path=SelectedItem}"/>
    <dxmvvm:KeyToCommand KeyGesture="F7" Command="{Binding OnClickOpenOutputWindowCommand}"  />
</dxmvvm:Interaction.Behaviors>
```

## 不支援 PassEventArgsToCommand 的替代做法

讓 KeyToCommand 預設就會傳 KeyEventArgs 至 ICommand\<KeyEventArgs> 中

```csharp
public class KeyToCommandNoBubble : KeyToCommand
{
    /// <summary>
    /// 在事件觸發後，才會執行的地方
    /// </summary>
    protected override void OnEvent(object sender, object eventArgs)
    {
        if (eventArgs is KeyEventArgs keyEventArgs)
        {
            keyEventArgs.Handled = true;
            CommandParameter = eventArgs;
        }

        base.OnEvent(sender, eventArgs);
    }
}
```
