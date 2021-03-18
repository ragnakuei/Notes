# [SaveFileDialogService](https://docs.devexpress.com/WPF/114760/mvvm-framework/services/predefined-set/savefiledialogservice)

```csharp
private ISaveFileDialogService SaveFileDialogService => this.GetService<ISaveFileDialogService>();

SaveFileDialogService.DefaultExt      = "json";
SaveFileDialogService.DefaultFileName = "Sample";
SaveFileDialogService.Filter          = "Json Files |*.json";
SaveFileDialogService.FilterIndex     = 1;

bool dialogResult = SaveFileDialogService.ShowDialog();
if (dialogResult)
{
    var fileContent = JsonConvert.SerializeObject(_chipInfoDto.PinFullInfo, Formatting.Indented);
    using (var stream = new StreamWriter(SaveFileDialogService.OpenFile()))
    {
        stream.Write(fileContent);
    }
}
```
