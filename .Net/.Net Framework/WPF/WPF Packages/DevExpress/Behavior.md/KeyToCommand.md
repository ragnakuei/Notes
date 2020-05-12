# [KeyToCommand](https://documentation.devexpress.com/WPF/113865/MVVM-Framework/Behaviors/Predefined-Set/KeyToCommand)

- 透過鍵盤的熱鍵來觸發 Event

```xml
 <dxmvvm:Interaction.Behaviors>
    <dxmvvm:KeyToCommand Command="{Binding EditCommand}" KeyGesture="Ctrl+Enter" CommandParameter="{Binding ElementName=list, Path=SelectedItem}"/>
</dxmvvm:Interaction.Behaviors>
```