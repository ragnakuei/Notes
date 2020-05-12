# Partial、RenderPartial

---

簡單說，就是不受_ViewStart.cshtml影響的View，通常也不指定Layout

取用 Partial View 的二個方式

### 方式一

直接顯示該檔案的內容，不會經過Action運作

```csharp
@Html.Partial("view_filename");
```

### 方式二

View 經過 Action Return PartialView() 後來顯示內容

```csharp
public ActionResult Get()
{
		return PartialView();
}
```

```csharp
@Html.Action("action_name");
```
