# 從 Description Attribute 取出 value 及 description

因為從 enum 取出的 value 及 description 是固定的，所以可以統一從 static 變數儲存。避免重複產生。

```csharp
private static Dictionary<int, string> Options
{
    get
    {

        return Enum.GetValues(typeof(AuthResult)).Cast<AuthResult>()
                   .ToDictionary(a => (int)a
                               , a => a.GetResult());
    }
}

void Main()
{
    Options.Dump();
}

public static class Helper
{
    public static string GetResult(this Enum value)
    {
        FieldInfo fi = value.GetType().GetField(value.ToString());

        var attributes = fi.GetCustomAttributes(typeof(DescriptionAttribute), false);

        return (attributes != null && attributes.Length > 0)
             ? (attributes[0] as DescriptionAttribute).Description
             : value.ToString();
    }
}

public enum AuthResult
{
    [Description("無")]
    None = -1, //無

    [Description("認證成功")]
    AuthecticationOk = 100,                 //認證成功

    [Description("認證權杖逾期")]
    AuthecticationTokenTimeout = 101,       //認證權杖逾期

    [Description("認證Token不合法")]
    InvalidAuthecticationToken = 102,       //認證Token不合法

    [Description("認證失敗")]
    AuthecticationFailed = 103,             //認證失敗
}
```
