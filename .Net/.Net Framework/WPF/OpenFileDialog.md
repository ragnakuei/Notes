# OpenFileDialog

- 與 Windows Form 的處理方式雷同
- WPF 的做法是透過 Button Click 來觸發

```csharp
private void btnOpenFile_Click(object sender, RoutedEventArgs e)
{
    OpenFileDialog openFileDialog = new OpenFileDialog();
    if(openFileDialog.ShowDialog() == true)
        txtEditor.Text = File.ReadAllText(openFileDialog.FileName);
}
```
