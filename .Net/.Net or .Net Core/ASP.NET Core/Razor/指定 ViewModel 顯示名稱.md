# 指定 ViewModel 顯示名稱.md

以下的 Razor 的套用語法

```html
<label asp-for="Id"></label>
```

而 ViewModel Property 上的 attribute ，用下面二種語法都可以

## Display()

```csharp
public class TestDisplayNameViewModel
{
    [Display(Name = "Test2")]
    public int Id { get; set; }
}
```

## DisplayName()

```csharp
public class TestDisplayNameViewModel
{
    [DisplayName("Test3")]
    public int Id { get; set; }
}
```
