# EditorFor

給定初始值的方式：
在 model 內設定 constructor，給定其初始值
然後在 controller 內實體化後，回傳給View就可以了

在 asp.net core mvc 的環境中，無法套用 new { required="required" } 的 attribute，可以先改用 TextBoxFor 替代…

Model

```csharp
public class Vdr()
{
	public Vdr()
	{
		VdrNo="0";
	}
}
```

Controller

```csharp
public ActionResult Create()
{
	var model = new Vdr();
	return View(model);
}
```