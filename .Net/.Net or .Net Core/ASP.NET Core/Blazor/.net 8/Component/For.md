# For

比 razor syntax @for / @foreach 更像是 html !

## Context

-   Context 視為該 RenderFragment 所回傳的型別變數
-   如果要將此 attribute 放在 Component 上，必須使用預設的 RenderFragment<T> 名稱：ChildContent

## 範例

For Razor Component：

```cs
@typeparam TItem

@code {
    // 自制的 For Razor Component

    /// <summary>
    /// 框架預設的 ItemTemplate
    /// </summary>
    [Parameter]
    public RenderFragment<TItem>? ChildContent { get; set; }

    /// <summary>
    /// 自訂的 ItemTemplate
    /// </summary>
    [Parameter]
    public RenderFragment<TItem>? ItemTemplate { get; set; }

    /// <summary>
    /// Items 為 Null 的 ItemTemplate
    /// </summary>
    [Parameter]
    public RenderFragment? NullTemplate { get; set; }

    /// <summary>
    /// Items 數量為 0 的 ItemTemplate
    /// </summary>
    [Parameter]
    public RenderFragment? NoItemTemplate { get; set; }

    /// <summary>
    /// 自訂的 ItemTemplate 並且帶有 Index
    /// </summary>
    [Parameter]
    public RenderFragment<(TItem item, int index)>? ItemIndexTemplate { get; set; }

    [Parameter]
    public IEnumerable<TItem>? Items { get; set; }

}

@{
    var index = 0;
}

@if (Items == null)
{
    @if (NullTemplate != null)
    {
        @NullTemplate
        return;
    }

    return;
}

@if (NoItemTemplate != null && Items.Count() == 0)
{
    @NoItemTemplate
    return;
}

@foreach (var item in Items)
{
    if (ItemIndexTemplate != null)
    {
        @ItemIndexTemplate.Invoke((item, index))
    }

    if (ItemTemplate != null)
    {
        @ItemTemplate.Invoke(item)
    }

    if (ChildContent != null)
    {
        @ChildContent.Invoke(item)
    }

    index++;
}
```

套用方式：

```html
<table class="table table-bordered">
    <thead>
        <tr>
            <th>Id</th>
            <th>Name</th>
        </tr>
    </thead>
    <tbody>
        <For Context="item" Items="_sixItems">
            <tr>
                <td>@item.Id</td>
                <td>@item.Name</td>
            </tr>
        </For>

        <tr>
            <td colspan="2"></td>
        </tr>

        <For Items="_sixItems">
            <ItemTemplate Context="item">
                <tr>
                    <td>@item.Id</td>
                    <td>@item.Name</td>
                </tr>
            </ItemTemplate>
        </For>

        <tr>
            <td colspan="2"></td>
        </tr>

        <For Items="_sixItems">
            <NullTemplate>
                <tr>
                    <td colspan="2">Loading</td>
                </tr>
            </NullTemplate>
            <NoItemTemplate>
                <tr>
                    <td colspan="2">No Item</td>
                </tr>
            </NoItemTemplate>
            <ItemIndexTemplate Context="itemIndex">
                <tr>
                    <td>@itemIndex.index - @itemIndex.item.Id</td>
                    <td>@itemIndex.item.Name</td>
                </tr>
            </ItemIndexTemplate>
        </For>
    </tbody>
</table>
```
