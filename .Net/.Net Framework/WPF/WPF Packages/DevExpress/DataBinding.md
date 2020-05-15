# DataBinding

## View 的 DataContext 來自於 ViewModelBase 時

- View 從 ViewModel 的 Property 取值時，所有的 Property 都要有 get、set，否則會取不到值(但也不會報錯)

- 如果用 ListView

  - 從 ViewModel 的 Property 取值時，語法不需要加 Path

    ```xml
    <UserControl.DataContext>
        <ViewModel:DocumentViewModel/>
    </UserControl.DataContext>

    <dxmvvm:Interaction.Behaviors>
        <dx:DXMessageBoxService/>
    </dxmvvm:Interaction.Behaviors>

    <ListView ItemsSource="{Binding OrderList}" Grid.Row="1">
        <ListView.ItemTemplate>
            <DataTemplate>
                <WrapPanel>
                    <TextBlock Text="{Binding}"></TextBlock>
                </WrapPanel>
            </DataTemplate>
        </ListView.ItemTemplate>
    </ListView>
    ```

    ```csharp
    public class DocumentViewModel : ViewModelBase
    {
        public string[] OrderList { get; set; } = new string[]
        {
            "A",
            "B",
            "C",
        };
    }
    ```

## 存取子

依照 View 顯示資料的控制項來決定是 One-Way Binding 還是 Two-Way Binding

| 控制項  | 說明                                     |                 |
| ------- | ---------------------------------------- | --------------- |
| Label   | 那麼 Property 存取子就可以設定成唯讀     | One-Way Binding |
| Textbox | 那麼 Property 存取子就必須設定成可讀可寫 | Two-Way-Binding |
