# FormFloatInput

```cs
@inherits InputText

<div class="form-floating @DivClass">
    <input type="@InputType"
           id="@Id"
           class="form-control @CssClass"
           @bind="CurrentValue" 
           placeholder="x"
           @attributes="AdditionalAttributes" 
           @bind:event="oninput" />
    <label class="col-form-label"
           for="@Id">
        @Label
    </label>
    <span class="invalid-feedback">
        @string.Join("、", EditContext.GetValidationMessages(FieldIdentifier))
    </span>
</div>

@code {

    [Parameter]
    public string DivClass { get; set; } = string.Empty;

    [Parameter]
    public string Label { get; set; } = string.Empty;

    [Parameter]
    public string Id { get; set; } = string.Empty;

    [Parameter]
    public string InputType { get; set; } = string.Empty;
}
```

套用方式：

```cs
@page "/ManageUser/Edit/{Id:guid}"
@using BusinessLogicLayer.ManagerUser
@using BusinessLogicLayer.Role
@using SharedLibrary.Models.ManageUser
@implements IDisposable

<PageTitle>使用者 編輯</PageTitle>

<h1>使用者 編輯</h1>

<EditForm autocomplete="off"
          EditContext="EditContext"
          OnValidSubmit="Update">
    <DataAnnotationsValidator />

    <FormFloatInput DivClass='mb-3'
                    Label='帳號'
                    Id='Account'
                    @bind-Value="Dto.Account"
                    InputType='"email"'>
    </FormFloatInput>

    <FormFloatInput DivClass='mb-3'
                    Label='名稱'
                    Id='Name'
                    @bind-Value='Dto.Name'
                    InputType='"text"'>
    </FormFloatInput>

    <FormFloatSelect DivClass="mb-3"
                     Label="角色"
                     Id="RoleId"
                     Options="RoleOptions"
                     @bind-Value="Dto.RoleId">
    </FormFloatSelect>

    <FormFloatInput DivClass='mb-3'
                    Label='備註'
                    Id='Remark'
                    @bind-Value='Dto.Remark'
                    InputType='"text"'>
    </FormFloatInput>

    <NavLink type="button"
             href="ManageUser/Index"
             class="me-3 btn btn-outline-primary">
        取消
    </NavLink>
    <button type="submit"
            class="me-3 btn btn-primary">
        更新
    </button>
</EditForm>

@code {

    [Inject]
    private IManageUserService? UserService { get; set; }

    [Inject]
    private IRoleService? RoleService { get; set; }

    [Parameter]
    public Guid Id { get; set; }

    private EditContext? EditContext { get; set; }

    private ValidationMessageStore? MessageStore { get; set; }

    private EditDto? Dto { get; set; }

    private Option<int?>[]? RoleOptions { get; set; }

    protected override void OnParametersSet()
    {
        Dto = UserService?.GetForEdit(Id);
        RoleOptions = RoleService?.GetOptions();

        EditContext = new EditContext(Dto);
        EditContext.OnValidationRequested += HandleValidationRequested;
        EditContext.SetFieldCssClassProvider(new Bootstrap5FieldClassProvider());

        MessageStore = new(EditContext);
    }

    public void Dispose()
    {
        if (EditContext is not null)
        {
            EditContext.OnValidationRequested -= HandleValidationRequested;
        }
    }

    private void HandleValidationRequested(object? sender, ValidationRequestedEventArgs e)
    {
        MessageStore?.Clear();
    }

    private void Update()
    {
        if (EditContext.Validate())
        {
        }
    }

}
```


```cs
public class Bootstrap5FieldClassProvider : FieldCssClassProvider
{
    public override string GetFieldCssClass(EditContext        editContext,
                                            in FieldIdentifier fieldIdentifier)
    {
        var isInvalid = editContext.GetValidationMessages(fieldIdentifier).Any();

        return isInvalid ? "is-invalid" : "is-valid";
    }
}
```