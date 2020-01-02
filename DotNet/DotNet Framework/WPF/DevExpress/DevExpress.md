# DevExpress

注意事項

- DataContext 的給定的語法不同，會影響 View 與 ViewModel 的生命週期

  - 於 Attribute 中給定

    於 View 初始化時，ViewModel 以較早的時機進行初始化

    ```xml
    <UserControl x:Class="WpfApp8.Main.MainView"
                 DataContext="{dxmvvm:ViewModelSource Type=local:MainView}">
    </UserControl>
    ```

  - 於 Element 中給定

    於 View 初始化時，ViewModel 以較晚的時機進行初始化

    ```xml
    <UserControl x:Class="WpfApp8.Main.MainView">
        <UserControl.DataContext>
            <local:MainViewModel />
        </UserControl.DataContext>
    </UserControl>
    ```

- 如果 ViewModel 繼承了 DevExpress 的 Interface 時，其成員最好都加上 virtual 宣告

  > 目前測試 ISupportParentViewModel.ParentViewModel 必須加上 virtual 宣告，功能才會正常
