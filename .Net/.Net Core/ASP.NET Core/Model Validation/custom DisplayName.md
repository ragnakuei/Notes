# custom DisplayName

DisplayName Attribute 可用於 tag helper label 用來顯示該欄位的名稱

如果要改變原本 DisplayName Attribute 的預設行為，可藉由繼承來 override 原本的行為

## Razor 讀取顯示名稱行為

會讀取 DisplayName.DisplayName 這個 Property 的值

可改此這個 Property Get 的行為來做彈性的變更 !


## 修改顯示名稱的行為範例

建立 CustomDisplayName Attribute Class

這個範例就會讓套用此 Attribute 的 Property 顯示名稱一律回傳 Test

```csharp
public class CustomDisplayNameAttribute : DisplayNameAttribute
{

    public CustomDisplayNameAttribute()
    {
    }

    public override string DisplayName {
        get
        {
            return "Test1";
        }
    }
}
```

建立 ViewModel

並在指定的 Property 上方加上 CustomDisplayName Attribute

```csharp
public class TestDisplayNameViewModel
{
    [CustomDisplayName]
    public int Id { get; set; }
}
```

套用至 Razor 上

```html
<label asp-for="Id"></label>
```