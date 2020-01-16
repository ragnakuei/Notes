# SaveFileDialog

- 與 Windows Form 的處理方式雷同
- WPF 的做法是透過 Button Click 來觸發

```csharp
private void btnSaveFile_Click(object sender, RoutedEventArgs e)
{
    SaveFileDialog saveFileDialog = new SaveFileDialog();
    if(saveFileDialog.ShowDialog() == true)
        File.WriteAllText(saveFileDialog.FileName, txtEditor.Text);
}
```
