# attributes

參考資料
- [Arbitrary attributes and parameters in Blazor](https://www.pragimtech.com/blog/blazor/blazor-arbitrary-attributes/)


### 範例一

- class 可以用 string 代替，如果有多個 class 則用空格隔開
- attributes 則必須以 Dictionary<string, object> 傳入
  - key 為 attribute name
  - value 為 attribute value (property ?)
    - 只需要給定 attribute name 時，value 則為 true
    - 要給定 attribute=value 時，value 則為 string


```cs
<div class="m-3 @DivClass" @attributes="DivAttributes">
    <button class="btn btn-primary" @onclick="ClickOn">On</button>
    <button class="btn btn-warning" @onclick="ClickOff">Off</button>
</div>

@code {
    private string DivClass;
    private Dictionary<string, object> DivAttributes = new();

    private void ClickOn()
    {
        DivClass = "p-3";

        // 給定 nowrap
        DivAttributes.Add("nowrap", true);

        // 給定 style="color:blue;"
        DivAttributes.Add("style", "color:blue");
    }

    private void ClickOff()
    {
        DivClass = string.Empty;
        DivAttributes.Clear();
    }
}
```