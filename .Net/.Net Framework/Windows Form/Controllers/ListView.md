# ListView

- 比 ListBox 的功能更多
- Items 為 ListViewItem 集合
- 支援多個 View Mode
- 動態新增 ListViewItem 時，可直接進入編輯模式

## 動態新增並進入編輯模式

- 編輯完畢之後，可以透過 AfterLabelEdit() Event 來做後續的判斷與處理

```csharp
private void btnNew_Click(object sender, EventArgs e)
{
    ListViewItem item = lsvProfiles.Items.Add(String.Empty);
    item.BeginEdit();
}

private void lsvProfiles_AfterLabelEdit(object sender, LabelEditEventArgs e)
{
    if (!(sender is ListView lsv))
    {
        return;
    }

    var newName = e.Label;

    if (string.IsNullOrWhiteSpace(newName))
    {
        e.CancelEdit = true;  // 不加這行，會導致 ListView 去更新 ListViewItem 而導致 Exception
        lsv.Items.RemoveAt(e.Item);
        lsv.SelectedItems.Clear();
        return;
    }

    var selectedListViewItem = lsv.Items[e.Item];

    if (selectedListViewItem == null)
    {
        return;
    }

    if (newName.Equals(selectedListViewItem.Text))
    {
        return;
    }

    _profilesManagementService.Rename(selectedListViewItem.Text, newName);
}
```

