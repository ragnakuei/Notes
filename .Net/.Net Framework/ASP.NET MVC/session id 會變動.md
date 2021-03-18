# session id 會變動

在 Global.asax.cs 中加上以下語法

```csharp
protected void Session_Start(Object sender, EventArgs e)
{
    Session["init"] = 0;
}
```
