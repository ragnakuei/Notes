# 在 code 中 route 至指定的 url 中


```cs
@page "/ManageUser/Edit/{Id:guid}"

// 略 ...

@inject NavigationManager NavigationManager;

// 略 ...

<EditForm autocomplete="off"
          EditContext="EditContext"
          OnValidSubmit="Update">
    <DataAnnotationsValidator />

    // 略 ...
    
</EditForm>

@code {

    // 略 ...

    private void Update()
    {
        Errors.Clear();
        Errors = InterceptException(() =>
                                    {
                                        Dto.UpdatorGuid = UserGuid;
                                        UserService.Update(Dto);
                                    });
        if (Errors.Count == 0)
        {
            NavigationManager.NavigateTo("ManageUser/Index");
        }
    }

}
```