
# 注意：這個寫法會抓不到 Exception

```csharp
public static void Main(string[] args)
{
    try
    {
        RunTaskAsync();
    }
    catch (Exception ex)
    {
        Console.WriteLine(ex.Message);
    }
    finally
    {
        Console.WriteLine("Complete");
    }
}

public static async void RunTaskAsync()
{
    throw new Exception("error");
}
```
