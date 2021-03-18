# 強制 method 以單執行續執行的方式 

[範例](https://github.com/ragnakuei/SingleThreadMethod)

```csharp
[MethodImpl(MethodImplOptions.Synchronized)]
public  int GetNo()
{
    _currentMaxNo++;

    return _currentMaxNo;
}
```