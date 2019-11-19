# Retry Pattern

## 語法

```csharp
void Main()
{
    Action action = () => {
        "Run".Dump();
        throw new Exception("Test");
    };
    
    
    Retry(action, 3);
}

public void Retry(Action action, int maxCount)
{
    var currentRetryCount = 0;
    
    while (true)
    {
        try
        {
            action.Invoke();
        }
        catch (Exception ex)
        {

            currentRetryCount++;
            $"currentRetryCount:{currentRetryCount}".Dump();

            if(currentRetryCount >= maxCount)
            {
                throw ex;
            }
        }

        Thread.Sleep(5000);
    }
}
```

## 參考資料

[Retry pattern](https://docs.microsoft.com/zh-tw/azure/architecture/patterns/retry)
