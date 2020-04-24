# Thread.Sleep 替代做法

```csharp
SpinWait.SpinUntil(() => false, timeoutInMs);
```

