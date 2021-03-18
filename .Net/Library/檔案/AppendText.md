# [AppendText](https://docs.microsoft.com/zh-tw/dotnet/api/system.io.file.appendtext)

```csharp
private void Log(object sender, ElapsedEventArgs e)
{
    if (!File.Exists(_logFilePath))
    {
        // Create a file to write to.
        using (StreamWriter sw = File.CreateText(_logFilePath))
        {
            sw.WriteLine("Live");
        }
    }
    else
    {
        using (StreamWriter sw = File.AppendText(_logFilePath))
        {
            sw.WriteLine("Live");
        }
    }
}
```