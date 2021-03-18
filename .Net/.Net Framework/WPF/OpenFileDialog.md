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


## 多個副檔名的指定方式

```csharp
using (OpenFileDialog openFileDialog = new OpenFileDialog())
{
    // 一個項目一個副檔名，共二個項目
    // openFileDialog.Filter           = "excel files (*.xls)|*.xls|excel files (*.xlsx)|*.xlsx";
    
    // 一個項目有二個以上的副檔名，共一個項目
    openFileDialog.Filter           = "excel files (*.xls, *.xlsx)|*.xls; *.xlsx";
    
    openFileDialog.FilterIndex      = 1;
    openFileDialog.RestoreDirectory = true;
    openFileDialog.Multiselect      = true;

    if (openFileDialog.ShowDialog() == DialogResult.OK)
    {
        _excelFilePaths = openFileDialog.FileNames;

        try
        {
            // ...
        }
        catch (Exception exception)
        {
            MessageBox.Show(exception.Message);
            MessageBox.Show("讀取檔案異常 !");
        }
    }
}
```