# 直接給定值至 html 中

```cs
<a href = "~/Products/products.aspx?pr_tp_sn=<%= Eval("id") %>" ><%= Eval("id") %></a>
```

### 不是 runat server

```html
<input
    type="button"
    class="btn btn-outline-primary btn-sm btn-fixed m-r-10"
    aria-label='<%= GetGlobalResourceObject("action", "清除條件") %>'
    value='<%= GetGlobalResourceObject("action", "清除條件") %>'
    onclick='document.getElementById("form1").reset()'
/>
```

### 是 runat server

#### 不是 Server Control

##### 範例 01

-   如果下面 nameof(propertyName) 要改成 字串的話，記得外層要用 單引號 包起來 !

    ```html
    <li class="<%# Eval(nameof(CategoryDto.ActiveClass)) %>"></li>
    ```

```html
        <asp:Repeater runat='server'
                      ID="MainCategoryRepeater">
            <ItemTemplate>
                <!-- 下面這一行的語法可以跑在非 runat=server 上，但是 Eval 要記得 ToString()，如果是 runat=server 就要事先算好 -->
                <!-- 下面這一行的語法如果要跑在 runat=server 上
                       該 attribute 只能只有 Eval 項目，不可以寫成 class="xxx <%# Eval(nameof(CategoryDto.ActiveClass)) %>" 
                       而且 Eval 的資料就必需是完整的，無法給定 Expression !
                       -->
                <%-- <li class='<%# MainCategoryId == Eval(nameof(CategoryDto.Id)).ToString() ? "active" : "" %>'> --%>

                <li class='<%# Eval(nameof(CategoryDto.ActiveClass)) %>'>

                    <a runat="server"
                       href="#"
                       OnServerClick="MainCategory_OnClick"
                       MainCategoryId='<%# Eval(nameof(CategoryDto.Id)) %>'>
                        <%# Eval(nameof(CategoryDto.Name)) %>
                    </a>

                </li>
            </ItemTemplate>
        </asp:Repeater>
```

```cs
protected void MainCategory_OnClick(object sender, EventArgs e)
{
    MainCategoryId = Int32.Parse(((HtmlAnchor)sender).Attributes[nameof(MainCategoryId)]);

    // bind active class
    InitialCategoryDtos();
    BindMainCategory();

    SubCategoryId = null;
    BindSubCategory(MainCategoryId);
}
```

#### 是 Server Control

```cs
<asp:Button runat='server'
            ID='btnSubmit'
            OnClick='btnSubmit_OnClick'
            Text='<%$ Resources : action,查詢%>'
            aria-label='<%$ Resources : action,查詢%>>'
            class="btn btn-primary btn-sm btn-fixed"
            UseSubmitBehavior='True'
            />
```
