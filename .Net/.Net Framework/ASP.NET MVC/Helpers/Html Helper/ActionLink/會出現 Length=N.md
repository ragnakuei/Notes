# 會出現?Length=N

---

錯誤版： 會出現?Length=4

```csharp
@Html.ActionLink("Show Video"
								, "fb_embed_video"
								, "Home" 
								, new { target = "_blank" })
```

正確版：

```csharp
@Html.ActionLink("Show Video"
								, "fb_embed_video"
								, new { Controller = "Home" }
								, new { target = "_blank" })
```

原因請參考

> 因為是選錯 overloading 所以就會處理錯誤

[The Will Will Web](https://blog.miniasp.com/post/2012/09/30/ASPNET-MVC-common-pitfall-for-html-actionlink-helper-method)