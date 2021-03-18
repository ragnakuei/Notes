# ActionLink 加上詢問 js 語法

---

會跳出 js 詢問視窗，如果未確認，就不會執行動作

```csharp
@Html.ActionLink("Confirm"
								, "confirm"
								, null
								, new { onclick = "return confirm('確定是否開啟連結')" })
```