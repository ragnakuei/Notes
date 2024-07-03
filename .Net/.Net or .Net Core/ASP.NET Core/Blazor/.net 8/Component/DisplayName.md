# DisplayName

原本的 Blazor 未提供以 Property Attribute Display 顯示欄位名稱

可以用以下的 Razor Component 來實作 !

注意事項：

1. 其中因為 label for 可 focus 至同名的 id 上，但又跟 Expression<Func<T>> 的名稱衝突
   ( 雖然大小寫名稱不同，但 Razor 視為相同 )

    所以只能把 for 改為 ForProperty，與內建的 ValidationMessage For 是相同的語法 !

1. 讓其餘可隨套用的 html attribute 可反映至 html tag 中

    透過 [Parameter(CaptureUnmatchedValues = true)] 把未對應的 attribute 如實呈現至指定的 html tag 中 !

```cs
@using System.ComponentModel.DataAnnotations
@using System.Linq.Expressions
@using System.Reflection
@typeparam T

@code {
    // 自制的 DisplayName Razor Component

    [Parameter]
    public Expression<Func<T>> ForProperty { get; set; }

    [Parameter(CaptureUnmatchedValues = true)]
    public Dictionary<string, object> AdditionalAttributes { get; set; }

    [Parameter]
    public RenderFragment? ChildContent { get; set; }

    protected override Task OnParametersSetAsync()
    {
        var expression = (MemberExpression)ForProperty.Body;
        var value      = expression.Member.GetCustomAttribute(typeof(DisplayAttribute)) as DisplayAttribute;
        _displayName = value?.Name ?? expression.Member.Name ?? "";

        _propertyName = expression.Member.Name;

        return base.OnParametersSetAsync();
    }

    private string? _displayName;
    private string? _propertyName;
}

<label @attributes="AdditionalAttributes" >
    @_displayName
    @if (ChildContent != null)
    {
        @ChildContent
    }
</label>
```

使用方式：

```html
<div class="mb-3 row">
    <DisplayName
        class="col-2 col-form-label"
        ForProperty="@(() => FormDto.Name)"
        for="Name"
    />
    <div class="col-10">
        <InputText @bind-Value="FormDto.Name" class="form-control" id="Name" />
        <ValidationMessage For="@(() => FormDto.Name)" />
    </div>
</div>
```
