# ComboBox

## 範例

-   建立 ComboBoxitem Class

    Value 的 object 可以用指定型別，最好不要用 object !

    ```csharp
    public class ComboBoxItem
    {
        public string Text { get; set; }
        public object Value { get; set; }
    }
    ```

-   cbxManager 是 ComboBox
-   指定 DisplayMember
-   指定 ValueMember

    ```csharp
    var managers = dbContext.User.Where(u => u.RoleId == (int)Role.Manager)
                            .Select(u => new ComboBoxItem
                                            {
                                                Value = u.Guid,
                                                Text  = u.Name
                                            })
                            .ToArray();

    cbxManager.DisplayMember = nameof(ComboBoxItem.Text);
    cbxManager.ValueMember = nameof(ComboBoxItem.Value);

    cbxManager.Items.AddRange(managers);
    ```

-   抓取資料

-   使用 SelectedItem as ComboBoxItem

    ```csharp
    if (cbxManager.SelectedItem is ComboBoxItem cbxItem)
    {
        _extractVendorService.SetManagerAndCreateTime(cbxItem.Value);

        WriteToDb();
    }
    ```
