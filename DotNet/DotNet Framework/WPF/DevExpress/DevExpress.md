# DevExpress

注意事項

- DataContext 的給定的語法不同

  - 於 Attribute 中給定

    ```xml
    <UserControl x:Class="WpfApp8.Main.MainView"
                 DataContext="{dxmvvm:ViewModelSource Type=local:MainView}">
    </UserControl>
    ```

  - 於 Element 中給定

    ```xml
    <UserControl x:Class="WpfApp8.Main.MainView">
        <UserControl.DataContext>
            <local:MainViewModel />
        </UserControl.DataContext>
    </UserControl>
    ```

  | 影響                              | 於 Attribute 中給定    | 於 Element 中給定      |
  | --------------------------------- | ---------------------- | ---------------------- |
  | 影響 View 與 ViewModel 的生命週期 | 以較早的時機進行初始化 | 以較晚的時機進行初始化 |
  | DevExpress 使用程度               | 高度使用，範例較多     | 範例較少               |

- 如果 ViewModel 繼承了 DevExpress 的 Interface 時，其成員最好都加上 virtual 宣告

  > 目前測試 ISupportParentViewModel.ParentViewModel 必須加上 virtual 宣告，功能才會正常

- Theme 會造成 bin 無法在未安裝 DevExpress 環境上執行

  [The default theme has been changed to "Office 2016 White"](https://supportcenter.devexpress.com/ticket/details/bc3420/the-default-theme-has-been-changed-to-office-2016-white)

  從 v16.1 開始，就內建使用 Theme Office2016White，如果是手動從 Toolbox 將 DevExperss 控制項加至專案內的話，不會加上任何 Theme 相關的 Assembly，如果未手動引用該 Theme Assembly 就會無法執行。解決方式有以下幾種

  - 引用 DevExpress.Xpf.Themes.Office2016White.v16.1 Assembly
  - 指定為 Legacy Theme
  
    可在 App.xaml.cs Constructor 中加上以下語法：

    ```csharp
    ApplicationThemeHelper.UseLegacyDefaultTheme = true;
    ```