# 搭配 Parallels 發生過的問題

- Debug 會正常，但在 Release 有時會掛掉，有時不會
  - 但是如果用 Enumerable.Range() 搭配 非同步，就測不出問題點

```cs
private readonly IHttpClientFactory _clientFactory;

private readonly HttpClient _httpClient;

public RunService(IHttpClientFactory clientFactory)
{
    _clientFactory = clientFactory;
    _httpClient = _clientFactory.CreateClient("HttpClientName");
}

public async Task RunParallelAsync()
{
    var tasks = new Task[_count * 2];

    Parallel.For(1, _count + 1, i => tasks[i          - 1] = PostAsync(_chargeUrl,  _chargeContent));
    Parallel.For(1, _count + 1, i => tasks[_count + i - 1] = PostAsync(_consumeUrl, _consumeContent));

    await Task.WhenAll(tasks);
}

private async Task PostAsync(string url, StringContent content)
{
    // 這個在 Debug 組態可以過
    // 但 Release 組態時掛掉可能性高於下面的語法
    // var response = await _clientFactory.CreateClient("HttpClientName").PostAsync(url, content);

    // 這個在 Relase 組態也會掛掉，但可能性比較低
    var response = await _httpClient.PostAsync(url, content);

    response.EnsureSuccessStatusCode();
}
```

Release 組態會掛掉，錯誤訊息：

```
Unhandled exception. System.ArgumentException: An item with the same key has already been added. Key: System.Net.Http.Headers.HeaderDescriptor
   at System.Collections.Generic.Dictionary`2.TryInsert(TKey key, TValue value, InsertionBehavior behavior)
   at System.Collections.Generic.Dictionary`2.Add(TKey key, TValue value)
   at System.Net.Http.Headers.HttpHeaders.GetOrCreateHeaderInfo(HeaderDescriptor descriptor, Boolean parseRawValues)
   at System.Net.Http.Headers.HttpHeaders.SetParsedValue(HeaderDescriptor descriptor, Object value)
   at System.Net.Http.Headers.HttpContentHeaders.get_ContentLength()
   at System.Net.Http.SocketsHttpHandler.ValidateAndNormalizeRequest(HttpRequestMessage request)
   at System.Net.Http.SocketsHttpHandler.SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
   at System.Net.Http.HttpClientHandler.SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
   at System.Net.Http.DelegatingHandler.SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
   at Microsoft.Extensions.Http.Logging.LoggingHttpMessageHandler.SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
   at Microsoft.Extensions.Http.Logging.LoggingScopeHttpMessageHandler.SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
   at System.Net.Http.HttpClient.SendAsyncCore(HttpRequestMessage request, HttpCompletionOption completionOption, Boolean async, Boolean emitTelemetryStartStop, CancellationT
oken cancellationToken)
   at Client.RunService.PostAsync(String url, StringContent content) in xxx\Client\RunService.cs:line 70

   at Client.RunService.RunParallelAsync() in xxx\Client\RunService.cs:line 45
   at Client.App.StartAsync(CancellationToken cancellationToken) in xxx\Client\App.cs:line 45
   at Microsoft.Extensions.Hosting.Internal.Host.StartAsync(CancellationToken cancellationToken)
   at Microsoft.Extensions.Hosting.HostingAbstractionsHostExtensions.RunAsync(IHost host, CancellationToken token)
   at Microsoft.Extensions.Hosting.HostingAbstractionsHostExtensions.RunAsync(IHost host, CancellationToken token)
   at Microsoft.Extensions.Hosting.HostingAbstractionsHostExtensions.Run(IHost host)
   at Client.Program.Main(String[] args) in xxx\Client\Program.cs:line 21

Process finished with exit code -532,462,766.
```