# 前端 Angular 後端 WebApi 套用 CSRF Token

開發階段 讓 Angular 與 Web Api 不同台 Host，所以必須設定 CORS 與 Cross Domain Cookie

上正式機時，會讓 Angular 與 Web Api 同站台，所以正式機不需要 CORS 與 Cross Domain Cookie

## 範例

完整範例在[這](https://github.com/ragnakuei/CrossSiteCsrfToken)

### 後端 WebApi

後端的設計
- 全部用 Http Post
- 除了取得 CSRF Token 的 Api 外，其餘 Api 都必須進行 CSRF Token 驗証

後端的 CSRF 驗証無法使用預設的，原因是：
- 因為 Startup.ConfigureService() 中 **AddControllersWithViews()** 所設定的才有加入 CSRF Token 驗証實作，這個實作包含了
  - Filter
    - AutoValidateAntiforgeryToken()
    - ValidateAntiforgeryToken()
- 但是 **AddControllers()** 則沒有加入 CSRF Token 驗証實作，如果直接加上 Filter，就會產生 Exception

所以後端 WebApi 只好加上自制 CSRF Token 驗証實作

而這個驗証驗實的範例就是 **CustomValidateAntiforgeryFilter**

其中比較關鍵的
- 未給定 CustomValidateAntiforgeryAttribute 視為 IsValidate = true
- 透過 Rseponse Cookie 來給定 Token
  - Cookie 就必須是 Cross Domain，才能讓前端框架讀到

```cs
/// <summary>
/// Validate Antiforgery Cookie + Token
/// Renew Antiforgery Token
/// </summary>
public class CustomValidateAntiforgeryFilter : ActionFilterAttribute
{
    public CustomValidateAntiforgeryFilter(ILogger<CustomValidateAntiforgeryFilter> logger,
                                            IAntiforgery                             antiforgery)
    {
        _logger      = logger;
        _antiforgery = antiforgery;
    }

    private readonly ILogger<CustomValidateAntiforgeryFilter> _logger;

    private readonly IAntiforgery _antiforgery;

    public override async Task OnActionExecutionAsync(ActionExecutingContext  context,
                                                        ActionExecutionDelegate next)
    {
        // 未給定 CustomValidateAntiforgeryAttribute 視為 IsValidate = true
        var isValidate = (context.ActionDescriptor as ControllerActionDescriptor)
                        ?.MethodInfo
                        ?.GetCustomAttribute<CustomValidateAntiforgeryAttribute>()
                        ?.IsValidate
                        ?? true;

        if (isValidate)
        {
            // Validate Antiforgery Cookie + Token
            await _antiforgery.ValidateRequestAsync(context.HttpContext);
        }

        // 可能多次取出相同的 Token，Expire 條件不清楚
        var tokenSet = _antiforgery.GetAndStoreTokens(context.HttpContext);

        // 每次拿取不同的 Token
        // var tokenSet = _antiforgery.GetTokens(context.HttpContext);

        var cookieOptions = _env.IsDevelopment()
                                ? new CookieOptions
                                    {   // 開發階段才需要 Cross Domain
                                        HttpOnly = false,
                                        Secure   = true,
                                        SameSite = SameSiteMode.None,
                                        Domain   = CorsConstSetting.Domain
                                    }
                                : new CookieOptions
                                    {
                                        HttpOnly = false,
                                        Secure   = true,
                                        SameSite = SameSiteMode.Strict
                                    };

        // 讓 CSRF Token 可以被前端存取 !
        context.HttpContext.Response.Cookies.Append(AntiforgeryConst.Header,
                                                    tokenSet.RequestToken,
                                                    cookieOptions);

        await base.OnActionExecutionAsync(context, next);
    }
}
```

其中 **CustomValidateAntiforgeryAttribute** 則是用來額外指定是否要進行 CSRF Token 的驗証

- 只要未給定此 Attribute，就會視為需要進行 CSRF 驗証
- 此 Attribute 只是用來強調不需要進行 CSRF 驗証
  - 或許之後可以改為 **IgnoreValidateAntiforgery**

```cs
public class CustomValidateAntiforgeryAttribute : Attribute
{
    public bool IsValidate { get; }

    public CustomValidateAntiforgeryAttribute(bool isValidate)
    {
        IsValidate = isValidate;
    }
}
```

Controller 套用 **CustomValidateAntiforgeryAttribute** 的範例

- Pose Request 至 Post1() 時，不會進行 CSRF 驗証 
  - 可以視為用來取得第一次的 CSRF Token !
- Pose Request 至 Post2() 時，會進行 CSRF 驗証 

```cs
[ApiController]
[Route("api/[controller]")]
public class TestController : ControllerBase
{
    [HttpPost]
    [Route("[action]")]
    [CustomValidateAntiforgery(false)]
    public IActionResult Post1()
    {
        return Ok();
    }

    [HttpPost]
    [Route("[action]")]
    public IActionResult Post2(object o)
    {
        return Ok(o);
    }
}
```

範例中，把 Antiforgery Cookie Name 跟 Header Name 都改掉，才能分得清楚其中的對應關係

Startup 其中比較關鍵的部份，寫在註解中

```cs
public class Startup
{
    private readonly IConfiguration      _configuration;
    private readonly IWebHostEnvironment _env;

    public Startup(IConfiguration      configuration,
                    IWebHostEnvironment env)
    {
        _configuration = configuration;
        _env           = env;
    }

    public void ConfigureServices(IServiceCollection services)
    {
        if (_env.IsDevelopment())
        {
            services.AddCors(options =>
                                {
                                    options.AddPolicy(name: CorsConstSetting.PolicyName,
                                                    builder =>
                                                    {
                                                        builder.WithOrigins(CorsConstSetting.Host)
                                                                .WithMethods("Post")
                                                                .AllowAnyHeader()
                                                                .AllowCredentials();
                                                    });
                                });
        }

        services.AddControllers(options =>
                                {
                                    // 加入自制的 CSRF 驗証實作
                                    options.Filters.Add<CustomValidateAntiforgeryFilter>();
                                });
        services.AddSwaggerGen(c =>
                                {
                                    c.SwaggerDoc("v1", new OpenApiInfo { Title = "WebApiServer", Version = "v1" });
                                });
        services.AddAntiforgery(options =>
                                {
                                    // web api 未使用 form，故註解
                                    // options.FormFieldName = "__RequestVerificationToken"; // 預設的名稱

                                    // options.HeaderName = "RequestVerificationToken"; // 預設的 Header

                                    // 使用自訂的 Header Name !
                                    options.HeaderName = AntiforgeryConst.Header;

                                    options.SuppressXFrameOptionsHeader = true;

                                    // 預設的 Antiforgery Cookie Name，其實有亂數字串，可能會比較自訂的好 !
                                    // 使用自訂的 Antiforgery Cookie
                                    options.Cookie.Name                 = AntiforgeryConst.Cookie;

                                    // 以下的指定讓 Antiforgery Cookie 可以 Cross Domain !
                                    options.Cookie.SameSite             = SameSiteMode.None;
                                    options.Cookie.SecurePolicy         = CookieSecurePolicy.Always;
                                    options.Cookie.Domain               = CorsConstSetting.Domain;
                                });
    }

    public void Configure(IApplicationBuilder app)
    {
        if (_env.IsDevelopment())
        {
            // 使用指定的 CORS Policy
            app.UseCors(CorsConstSetting.PolicyName);

            app.UseDeveloperExceptionPage();
            app.UseSwagger();
            app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "WebApiServer v1"));
        }

        app.UseHttpsRedirection();

        app.UseRouting();

        app.UseAuthorization();

        app.UseEndpoints(endpoints =>
                            {
                                endpoints.MapControllers();
                            });
    }
}
```

上述提到的 Const

```cs
public class CorsConstSetting
{
    public static string PolicyName = "angular";
    public static string Host       = "http://localhost:4200";
    public static string Domain     = "localhost";
}

public class AntiforgeryConst
{
    public static string Cookie = ".AspNetCore.Antiforgery";

    public static string Header = ".AspNetCore.Antiforgery.Token";
}
```

### 前端 Angular

先加上測試環境可以直接 proxy 至後端 WebApi 的設定，可以參考[這](../../../../FrontEnd/Javascript%20Frameworks/Angular/開發階段%20設定%20proxy%20server.md)

主要就是加上一個 TestComponent，然後直接在 App Component

- 其中大量註解的部份，主要測試後端 IAntiforgery.GetTokens() 與 IAntiforgery.GetAndStoreTokens() 用的 !

```ts
import { Component, OnInit } from '@angular/core';
import { CookieService } from "ngx-cookie-service";

@Component({
  selector: 'app-test',
  templateUrl: './test.component.html',
  styleUrls: [ './test.component.css' ]
})
export class TestComponent implements OnInit {

  private _antiforgeryToken: string = '';

  constructor(private readonly _cookieService: CookieService) {
  }


  async ngOnInit(): Promise<void> {
    await this.getCsrkToken();
  }

  async getCsrkToken(): Promise<any> {

    await this.RequestToPost1();

    // const antiforgeryToken1 = this._cookieService.get('.AspNetCore.Antiforgery.Token');
    // console.log('antiforgeryToken1', antiforgeryToken1);
    this._antiforgeryToken = this._cookieService.get('.AspNetCore.Antiforgery.Token');
    console.log('this._antiforgeryToken', this._antiforgeryToken);

    await this.RequestToPost2(1);

    // const antiforgeryToken1 = this._cookieService.get('.AspNetCore.Antiforgery.Token');
    // console.log('antiforgeryToken1', antiforgeryToken1);
    // this._antiforgeryToken = this._cookieService.get('.AspNetCore.Antiforgery.Token');
    console.log('this._antiforgeryToken', this._antiforgeryToken);

    await this.RequestToPost2(2);

    // const antiforgeryToken1 = this._cookieService.get('.AspNetCore.Antiforgery.Token');
    // console.log('antiforgeryToken1', antiforgeryToken1);
    // this._antiforgeryToken = this._cookieService.get('.AspNetCore.Antiforgery.Token');
    console.log('this._antiforgeryToken', this._antiforgeryToken);

    await this.RequestToPost2(3);
  }

  RequestToPost1(): Promise<null> {
    return fetch('/api/Test/Post1',
      {
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'content-type': 'application/json',
        },
        body: null,
        method: 'POST',
        credentials: 'include',
      })
      .then((response: Response) => {

        if (!response.ok) {
          throw response;
        }

        return null;
      });
  }

  private async RequestToPost2(id: number) {

    const requestBody = { id: id };

    return await fetch('/api/Test/Post2',
      {
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'content-type': 'application/json',
          '.AspNetCore.Antiforgery.Token': this._antiforgeryToken,
        },
        body: JSON.stringify(requestBody),
        method: 'POST',
        credentials: 'include',
      })
      .then((response: Response) => {

        if (!response.ok) {
          throw response;
        }

        return response.json();
      }).then((requestBody: { id: number }) => {
        console.log('requestBody', requestBody);
      });
  }
}
```
