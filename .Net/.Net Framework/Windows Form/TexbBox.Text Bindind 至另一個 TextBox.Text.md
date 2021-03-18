# TexbBox.Text Bindind 至另一個 TextBox.Text

```csharp
var binding = new Binding("Text", 
                          tbxTarget, 
                          "Text", 
                          true, 
                          DataSourceUpdateMode.OnPropertyChanged);
tbxSource.DataBindings.Add(binding);
```