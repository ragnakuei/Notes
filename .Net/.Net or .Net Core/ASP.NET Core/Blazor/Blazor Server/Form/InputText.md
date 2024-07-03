# InputText


#### 套用 ValueChanged 事件

- 不可使用 @onchange 屬性
  - 這只適用於 html dom，而不適用於 InputText 這類的元件
- 不可使用 two-way binding 的 @bind-value，要改用
  - Value
  - ValueExpression
  - ValueChanged
    - 參數傳入欲變更後的值


```csharp
<EditForm EditContext="@_newContext"
    OnSubmit="SubmitForm"
    >
    <InputText ValueChanged="InputChangeAsync"
               Value="@_dto.InputValue"
               ValueExpression="() => _dto.InputValue">
    </InputText>

    <input type="submit" value="Submit" />
</EditForm>

@code {
    private EditContext? _newContext;

    private Dto _dto = new();

    protected override async Task OnInitializedAsync()
    {
        _newContext = new EditContext(_dto);
    }

    private async Task InputChangeAsync(string newValue)
    {
        _dto.InputValue = newValue + "z";

        await Task.CompletedTask;
    }

    private void SubmitForm()
    {
        var dto = (Dto)_newContext.Model;
    }
}

public class Dto
{
    public string InputValue { get; set; }
}
```
