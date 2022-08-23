# 不使用 PageModel 的邏輯進行處理

-   只需要 .cshtml 檔
-   不需要 .cshtml.cs 檔
-   不需要指定 @model
-   @functions block 內，視為 csharp 語法
-   無法使用 Constructor
-   可以使用 @inject 來 DI 物件

```html
@page @{ } @functions{ public string Message { get; set; } = "Initial Request";
}

<h3 class="clearfix">@Message</h3>
```

### 範例一

Result.cshtml

```cs
@page

<form asp-antiforgery="true"></form>
<div id="result"></div>

@{
}

@section Scripts
{
    <script>
        fetch('@Url.PageLink("/Api")',{
              body: null,
              headers: {
                'content-type': 'application/json',
                RequestVerificationToken: $('input:hidden[name="__RequestVerificationToken"]').val()
              },
              method: 'POST',
            })
            .then(response => response.json()) // 輸出成 json

        fetch('@Url.PageLink("/Test3")',{
              body: null,
              headers: {
                'content-type': 'application/json',
                RequestVerificationToken: $('input:hidden[name="__RequestVerificationToken"]').val()
              },
              method: 'GET',
            })
            .then(response => response.text())
            .then(responseBody => {
                $('#result').html(responseBody);
            });
    </script>
}

```

Api.cshtml

-   支援 Get / Post

```cs
@page
@{
    Layout = null;
}

<p>@Html.Raw(Message)</p>

@functions
{
    public string Message { get; set; }

    public void OnGet()
    {
        Message = "Hello World !";
    }

    public IActionResult OnPost()
    {
        return new JsonResult(new
                              {
                                  Id = 1,
                                  Name = "A",
                              });
    }
}
```
