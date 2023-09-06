# HttpClient error handling

## 範例 01

-   使用統一的 Response DTO

    ```cs
    public class ResponseDto
    {
        public bool   IsFormValid { get; set; }
        public string Message     { get; set; }
    }
    ```

##### Web API 端

-   使用 WebApiException Middleware

    ```cs
    app.UseMiddleware<WebApiExceptionMiddleware>();

    public class WebApiExceptionMiddleware
    {
        public WebApiExceptionMiddleware(RequestDelegate                    next,
                                        ILogger<WebApiExceptionMiddleware> logger)
        {
            _logger = logger;
            _next   = next;
        }

        private readonly ILogger<WebApiExceptionMiddleware> _logger;

        private readonly RequestDelegate _next;

        public async Task InvokeAsync(HttpContext httpContext)
        {
            try
            {
                await _next(httpContext);
            }
            catch (Exception ex)
            {
                await HandleExceptionAsync(httpContext, ex);
            }
        }

        private async Task HandleExceptionAsync(HttpContext context, Exception ex)
        {
            await WriteAsync(context,
                            (int)HttpStatusCode.InternalServerError,
                            new ResponseDto
                            {
                                IsFormValid = false,
                                Message     = "發生錯誤，請聯絡開發人員 !"
                            });
        }

        private async Task WriteAsync(HttpContext context,
                                    int         statusCode,
                                    ResponseDto responseDto)
        {
            context.Response.ContentType = "application/json";
            context.Response.StatusCode  = statusCode;

            await context.Response.WriteAsync(JsonSerializer.Serialize(responseDto));
        }
    }
    ```

-   拋出 Exception 的 Controller

    ```cs
    [ApiController]
    [Route("[controller]")]
    public class TestController : ControllerBase
    {
        [HttpGet]
        public IActionResult Get()
        {
            throw new Exception();
        }
    }
    ```

##### Blazor WASM 端

-   FetchDataService.cs

    這邊以 FetchDataService 來模擬 HttpClientService 的動作 !


    ```cs
    public class FetchDataService
    {
        private readonly HttpClient        _http;
        private readonly NavigationManager _navigationManager;
        private readonly ErrorStore        _errorStore;

        public FetchDataService(HttpClient        http,
                                NavigationManager navigationManager,
                                ErrorStore        errorStore)
        {
            _http              = http;
            _navigationManager = navigationManager;
            _errorStore        = errorStore;
        }

        public async Task<WeatherForecast[]?> GetAsync()
        {
            var response = await _http.GetAsync("Test");

            if (response.IsSuccessStatusCode == false)
            {
                HandleErrorIfHas(response);
                return null;
            }

            var responseBodyJson = await response.Content.ReadAsStringAsync();

            var responseBody = JsonSerializer.Deserialize<WeatherForecast[]>(responseBodyJson);

            return responseBody;
        }

        private void HandleErrorIfHas(HttpResponseMessage response)
        {
            _errorStore.Error = response;
            _navigationManager.NavigateTo("/error");
        }
    }
    ```

-   ErrorStore.cs
    
    用來儲存 Error Response 的資料 !

    ```cs
    public class ErrorStore
    {
        public HttpResponseMessage Error { get; set; }
    }
    ```

-   Error.razor

    此頁就可以顯示相關的 Error Message !

    ```cs
    @page "/Error"
    @using BlazorApp02.Client.Store
    @using BlazorApp02.Shared.Models
    @inject ErrorStore errorStore
    <h3>Error</h3>

    <div>
        <div>
            Message: @_responseDto.Message
        </div>
        <div>
            IsFormValid: @_responseDto.IsFormValid
        </div>
    </div>

    @code {

        private ResponseDto _responseDto;

        protected override async Task OnInitializedAsync()
        {
            var error = errorStore.Error;

            _responseDto = await error.Content.ReadFromJsonAsync<ResponseDto>();

            await base.OnInitializedAsync();
        }

    }
    ```
