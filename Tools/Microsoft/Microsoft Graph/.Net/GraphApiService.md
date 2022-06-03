# GraphApiService

- 用於 Application Permission
- 

## GraphApiService

```cs
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

public interface IGraphApiService
{
    Task<T> GetAsync<T>(string url);

    Task<T> PostAsync<T>(string url, object requestBody);

    Task<T> PatchAsync<T>(string url, object requestBody);

    Task<T> DeleteAsync<T>(string url);

    Task PostAsync(string url, object requestBody);

    Task PatchAsync(string url, object requestBody);
}

public class GraphApiService : IGraphApiService
{
    private readonly IHttpClientFactory     _clientFactory;
    private readonly IAccessTokenRepository _accessTokenRepository;
    private readonly int                    _maxRetryCount = 3;

    public GraphApiService(IHttpClientFactory     clientFactory,
                           IAccessTokenRepository accessTokenRepository)
    {
        _clientFactory         = clientFactory;
        _accessTokenRepository = accessTokenRepository;
    }

    public async Task<T> GetAsync<T>(string url)
    {
        return await RequestAsync<T>("GET", url, null);
    }

    public async Task<T> PostAsync<T>(string url, object requestBody)
    {
        return await RequestAsync<T>("POST", url, requestBody);
    }

    public async Task<T> PatchAsync<T>(string url, object requestBody)
    {
        return await RequestAsync<T>("PATCH", url, requestBody);
    }

    public async Task<T> DeleteAsync<T>(string url)
    {
        return await RequestAsync<T>("DELETE", url, null);
    }

    public async Task PostAsync(string url, object requestBody)
    {
        await RequestAsync("POST", url, requestBody);
    }

    public async Task PatchAsync(string url, object requestBody)
    {
        await RequestAsync("PATCH", url, requestBody);
    }

    private async Task<T> RequestAsync<T>(string httpMethod,
                                            string url,
                                            object requestBody,
                                            int    retryCount = 0)
    {
        var client = await GetHttpClientWithAccessToken();

        var fullUrl = AppendGraphApiVersion(url);

        var request = new HttpRequestMessage(new HttpMethod(httpMethod), fullUrl);

        if (httpMethod != "GET")
        {
            var requestBodyJson = JsonConvert.SerializeObject(requestBody,
                                                                // 只更新必要的 Properties !
                                                                new JsonSerializerSettings
                                                                {
                                                                    NullValueHandling = NullValueHandling.Ignore
                                                                });

            request.Content = new StringContent(requestBodyJson,
                                                Encoding.UTF8,
                                                "application/json");
        }

        var response = await client.SendAsync(request);
        if (response.IsSuccessStatusCode)
        {
            // Debug 用
            // var json = await response.Content.ReadAsStringAsync();
            // return json;

            var result = await response.Content.ReadAsAsync<T>();
            return result;
        }

        Func<int, Task<T>> retryFunct = (retryCnt) => RequestAsync<T>(httpMethod, url, requestBody, retryCnt);

        return await HandleNonSuccessResponse(response, retryCount, retryFunct);
    }

    private async Task RequestAsync(string httpMethod,
                                    string url,
                                    object requestBody,
                                    int    retryCount = 0)
    {
        var client = await GetHttpClientWithAccessToken();

        var fullUrl = AppendGraphApiVersion(url);

        var request = new HttpRequestMessage(new HttpMethod(httpMethod), fullUrl);

        if (httpMethod != "GET")
        {
            var requestBodyJson = JsonConvert.SerializeObject(requestBody,
                                                                // 只更新必要的 Properties !
                                                                new JsonSerializerSettings
                                                                {
                                                                    NullValueHandling = NullValueHandling.Ignore
                                                                });

            request.Content = new StringContent(requestBodyJson,
                                                Encoding.UTF8,
                                                "application/json");
        }

        var response = await client.SendAsync(request);
        if (response.IsSuccessStatusCode)
        {
            return;
        }

        Func<int, Task> retryFunct = (retryCnt) => RequestAsync(httpMethod, url, requestBody, retryCnt);

        await HandleNonSuccessResponse(response, retryCount, retryFunct);
    }

    private async Task<HttpClient> GetHttpClientWithAccessToken()
    {
        var client = _clientFactory.CreateClient();
        client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

        // 傳回指定語系的資料
        client.DefaultRequestHeaders.Add("accept-language", "zh-TW");

        var accessToken = await _accessTokenRepository.GetAsync();
        client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);
        return client;
    }

    /// <summary>
    /// 透過拋出 Exception 中斷後續處理
    /// </summary>
    private async Task<T> HandleNonSuccessResponse<T>(HttpResponseMessage response,
                                                        int                 retryCount,
                                                        Func<int, Task<T>>  retryFunc)
    {
        var errorMessage = "RequestMessage:" + response.RequestMessage;
        var errorJson    = await response.Content.ReadAsStringAsync();

        if (retryCount <= _maxRetryCount
            && (errorJson ?? string.Empty).Contains("Access token has expired"))
        {
            // 重取 AccessToken 並重新執行
            retryCount++;

            Debug.WriteLine($"Access token has expired, retry count:{retryCount}");

            await Task.Delay(1000 * retryCount);

            return await retryFunc.Invoke(retryCount);
        }

        errorMessage += $"\n error content：{errorJson}";
        throw new Exception(errorMessage);
    }

    /// <summary>
    /// 透過拋出 Exception 中斷後續處理
    /// </summary>
    private async Task HandleNonSuccessResponse(HttpResponseMessage response,
                                                int                 retryCount,
                                                Func<int, Task>     retryFunc)
    {
        var errorMessage = "RequestMessage:" + response.RequestMessage;
        var errorJson    = await response.Content.ReadAsStringAsync();

        if (retryCount <= _maxRetryCount
            && (errorJson ?? string.Empty).Contains("Access token has expired"))
        {
            // 重取 AccessToken 並重新執行
            retryCount++;

            Debug.WriteLine($"Access token has expired, retry count:{retryCount}");

            await Task.Delay(1000 * retryCount);

            await retryFunc.Invoke(retryCount);
        }

        errorMessage += $"\n error content：{errorJson}";
        throw new Exception(errorMessage);
    }

    private string AppendGraphApiVersion(string url)
    {
        var result = Path.Combine(AuthenticationConfig.ApiUrl, "v1.0", url).Replace("\\", "/");
        return result;
    }
}
```

## IAccessTokenRepository

- 透過 MemoryCache 來記錄 AccessToken

```cs
using Microsoft.Identity.Client;

public interface IAccessTokenRepository
{
    Task<string> GetAsync(Guid userId);
}

public class AccessTokenRepository : IAccessTokenRepository
{
    private readonly IMemoryCacheService _memoryCacheService;

    private readonly string _accessTokenCacheKey = "AccessToken";

    public AccessTokenRepository(IMemoryCacheService memoryCacheService)
    {
        _memoryCacheService = memoryCacheService;
    }

    public async Task<string> GetAsync(Guid userId)
    {
        var accessToken = _memoryCacheService.Get<string>(_accessTokenCacheKey + userId);
        if (string.IsNullOrWhiteSpace(accessToken) == false)
        {
            return accessToken;
        }

        var app = ConfidentialClientApplicationBuilder.Create(AuthenticationConfig.ClientId)
                                                      .WithClientSecret(AuthenticationConfig.ClientSecret)
                                                      .WithAuthority(new Uri(AuthenticationConfig.Authority))
                                                      .Build();

        var scopes = new string[] { $"{AuthenticationConfig.ApiUrl}.default" };

        var result = await app.AcquireTokenForClient(scopes)
                                .ExecuteAsync();
        accessToken = result.AccessToken;

        // Access Token 一小時後逾期
        _memoryCacheService.Set(_accessTokenCacheKey, accessToken, TimeSpan.FromHours(1));

        return accessToken;
    }
}
```