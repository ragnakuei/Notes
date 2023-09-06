# 套用後端給的 Cookie

因為要套用 CookieHandler，所以必須經過 IHttpClientFactory 的 CreateClient() 方法，來使用 HttpClient。

套件

- Microsoft.Extensions.Http

Program.cs

```cs
using BlazorApp01.Client;
using BlazorApp01.Client.Infra;
using BlazorApp01.Shared.Consts;
using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;

var builder = WebAssemblyHostBuilder.CreateDefault(args);
builder.RootComponents.Add<App>("#app");
builder.RootComponents.Add<HeadOutlet>("head::after");

builder.Services.AddScoped<CookieHandler>();
builder.Services.AddHttpClient(HttpClientName.Default,
                               (sp, httpclient) =>
                               {
                                   httpclient.BaseAddress = new Uri("https://localhost:7162");
                               })
       .AddHttpMessageHandler<CookieHandler>();

await builder.Build().RunAsync();
```

HttpClientName.cs

```cs
public class HttpClientName
{
    public static readonly string Default = "Default";
}
```

CookieHandler.cs

```cs
public class CookieHandler : DelegatingHandler
{
    protected override async Task<HttpResponseMessage> SendAsync(HttpRequestMessage request,
                                                                 CancellationToken  cancellationToken)
    {
        request.SetBrowserRequestCredentials(BrowserRequestCredentials.Include);

        return await base.SendAsync(request, cancellationToken);
    }
}
```


Login.page

```cs
@page "/Login"
@using System.Net
@using BlazorApp01.Shared.Models
@using KueiPackages.Models
@using Microsoft.AspNetCore.Components
@inject IJSRuntime _jsRuntime
@inject IHttpClientFactory _clientFactory

<PageTitle>Login</PageTitle>

<h1>Login</h1>

<EditForm EditContext="@editContext"
          OnValidSubmit="@HandleValidSubmit">
    <DataAnnotationsValidator />
    <ValidationSummary />
    <h1 class="mb-3 row d-flex justify-content-center">
        會議室預約系統
    </h1>

    <div class="mb-3 row">
        <div class="col-12 text-start col-sm-2 col-md-3 col-lg-4 text-sm-end">
            <label asp-for="Dto.Account"
                   class="col-form-label">
                帳號：
            </label>
        </div>
        <div class="col-12 col-sm-8 col-md-6 col-lg-4">
            <InputText class="form-control"
                       @bind-Value="_loginFormDto.Account" />
        </div>
        <div class="col-12 col-sm-2 col-md-3 col-lg-4 col-form-label validation-message">
            <ValidationMessage For="@(() => _loginFormDto.Account)" />
        </div>
    </div>

    <div class="mb-3 row">
        <div class="col-12 text-start col-sm-2 col-md-3 col-lg-4 text-sm-end">
            <label asp-for="Dto.Account"
                   class="col-form-label">
                密碼：
            </label>
        </div>
        <div class="col-12 col-sm-8 col-md-6 col-lg-4">
            <InputText class="form-control"
                       type='password'
                       @bind-Value="_loginFormDto.Password" />
        </div>
        <div class="col-12 col-sm-2 col-md-3 col-lg-4 col-form-label validation-message">
            <ValidationMessage For="@(() => _loginFormDto.Password)" />
        </div>
    </div>


    <div class="mb-3 d-flex justify-content-center">
        <input type="submit"
               class="btn btn-primary"
               value="登入" />
    </div>
</EditForm>

@code {
    private EditContext? editContext;

    private LoginFormDto _loginFormDto = new();

    private ValidationMessageStore? messageStore;

    protected override void OnInitialized()
    {
        editContext = new(_loginFormDto);
        editContext.OnValidationRequested += HandleValidationRequested;
        messageStore = new(editContext);
    }

    private void HandleValidationRequested(object? sender,
                                           ValidationRequestedEventArgs args)
    {
        messageStore?.Clear();
        // 自訂驗証邏輯
    }

    private async Task HandleValidSubmit()
    {
        if (editContext != null && editContext.Validate())
        {
            var response = await _clientFactory.CreateClient(HttpClientName.Default).PostAsJsonAsync("api/Account/PostLogin", (LoginFormDto)editContext.Model);

            var responseDto = await response.Content.ReadFromJsonAsync<ResponseDto>();

            _jsRuntime.InvokeVoidAsync("console.log", responseDto);

            if (string.IsNullOrWhiteSpace(responseDto?.AlertMessage) == false)
            {
                await _jsRuntime.InvokeVoidAsync("alert", responseDto.AlertMessage);
            }
            if (string.IsNullOrWhiteSpace(responseDto?.Message) == false)
            {
                await _jsRuntime.InvokeVoidAsync("alert", responseDto.Message);
            }

            if (response.StatusCode == HttpStatusCode.BadRequest)
            {
    
            }
            else if (!response.IsSuccessStatusCode)
            {
                throw new HttpRequestException($"Validation failed. Status Code: {response.StatusCode}");
            }
            else
            {
                Console.WriteLine("Login success");
            }

            return;
        }

    
    }

    public void Dispose()
    {
        if (editContext is not null)
        {
            editContext.OnValidationRequested -= HandleValidationRequested;
        }
    }

}
```