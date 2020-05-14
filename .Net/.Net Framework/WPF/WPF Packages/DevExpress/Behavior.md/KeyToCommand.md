# [KeyToCommand](https://documentation.devexpress.com/WPF/113865/MVVM-Framework/Behaviors/Predefined-Set/KeyToCommand)

- 透過鍵盤的熱鍵來觸發 Event

```xml
 <dxmvvm:Interaction.Behaviors>
    <dxmvvm:KeyToCommand KeyGesture="Ctrl+Enter" Command="{Binding EditCommand}" CommandParameter="{Binding ElementName=list, Path=SelectedItem}"/>
    <dxmvvm:KeyToCommand KeyGesture="F7" Command="{Binding OnClickOpenOutputWindowCommand}"  />
</dxmvvm:Interaction.Behaviors>
```