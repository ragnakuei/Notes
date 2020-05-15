# ActionLink

ActionLink(string1,string2,string3)

string1:顯示的超連結文字

string2:action

string3:controller

ActionLink(string1,string2,object1)

string1:顯示的超連結文字

string2:action

object1:虛擬路徑，通常會以 new { id=item.Id } 表示

最佳替代方式：用 Button + JS 就可以了

```csharp
<input type="button" id="reset"
       value="重置訂單" 
       onclick="javascript:location.href='@Url.Action("Order")'" />
```