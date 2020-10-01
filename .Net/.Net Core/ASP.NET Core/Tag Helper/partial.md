# [partial](https://www.learnrazorpages.com/razor-pages/partial-pages)

套用 partial view 

```xml
<partial name="_OrderDetailPartial" model="OrderDetail"/>
```

model 與 for

- 就拿到資料的角度庲說，這二個沒有差異
- 差異在於是否需要 post back 時的 model binding !

## model

這個會以單純的 Model 放進 partial 中處理  
實際上 `不會` 帶出呼叫 partial 頁面上 Model 的 Property Name  
會影響之後的 Post Back 做 Model Binding 失敗
如果只是單純顯示資料，可以使用這個方式  


```csharp
<partial name="_OrderDetailPartial" model="OrderDetail"/>
```

## for

這個除了會以單純的 Model 放進 partial 中處理  
還 `會` 帶出呼叫 partial 頁面上 Model 的 Property Name  
方便之後 Post Back 做 Model Binding 做進一步處理

```csharp
<partial name="_OrderDetailPartial" for="@OrderDetail"/>
```

### 範例

假設傳入的 Model 是這樣

```csharp
[HttpGet]
public IActionResult Test()
{
    var viewModel = new DtoA
                    {
                        Id = 3,
                        DtoBs = new[]
                                {
                                    new DtoB { Id = 4, },
                                    new DtoB
                                    {
                                        Id = 5,
                                        DtoCs = new[]
                                                {
                                                    new DtoC { Id = 6 },
                                                    new DtoC { Id = 7 },
                                                }
                                    },
                                }
                    };

    return View(viewModel);
}
```

那麼在 View 要可以成功 binding 回來，就可以用以下的語法

- Test.cshtml

    ```csharp
    <form method="post"
        asp-action="Test">
        <p>
            <input asp-for="Id">
        </p>

        <partial name="_DtoBs"
                for="DtoBs" />

        <input type="submit"
            value="Submit" />
    </form>
    ```

- _DtosBs.cshtml

    ```csharp
    @model NestedViewModelsBinding.Controllers.DtoB[]

    @if (Model?.Length > 0)
    {

        for (var bIndex = 0; bIndex < Model.Length; bIndex++)
        {
            <p>
                <input asp-for="@Model[bIndex].Id">
            </p>

            if (Model[bIndex].DtoCs?.Length > 0)
            {
                <partial name="_DtoCs"
                        for="@Model[bIndex].DtoCs" />
            }
        }
    }

    ```
- _DtosCs.cshtml

    ```csharp
    @model NestedViewModelsBinding.Controllers.DtoC[]

    @if (Model?.Length > 0)
    {
        for (var cIndex = 0; cIndex < Model.Length; cIndex++)
        {
            <p>
                <input asp-for="@Model[cIndex].Id">
            </p>
        }
    }

    ```

來傳回 

```csharp
[HttpPost]
[ActionName("Test")]
public IActionResult PostTest(DtoA dtoA)
{
    return View(dtoA);
}
```