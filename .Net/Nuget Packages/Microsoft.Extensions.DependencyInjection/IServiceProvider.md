# IServiceProvider

可取得的地方

- IHttpContextAccessor.HttpContext.RequestServices
- 直接透過 DI

目前測試透過 DI 取得的 instance，以下三個的生命週期為一致

- 透過 DI 至 Constructor
- IHttpContextAccessor.HttpContext.RequestServices.GetServices\<T>
- 透過 DI 至 Constructor 的 IServiceProvider.GetServices\<T>

但是，DI IServiceProvider 實際上是違反 DI 原則的 !