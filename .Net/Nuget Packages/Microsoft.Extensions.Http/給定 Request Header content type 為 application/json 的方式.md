# 給定 Request Header content type 為 application/json 的方式

```cs
var client = _httpClientFactory.CreateClient();

// 不可用
// client.DefaultRequestHeaders.Add("Content-Type",  "application/json");
// 要用
client.DefaultRequestHeaders
      .Accept
      .Add(new MediaTypeWithQualityHeaderValue("application/json"));

client.DefaultRequestHeaders.Add("Authorization", $"Bearer {_appSetting.CurrentValue.OPENAI_API_KEY}");

using var request = new HttpRequestMessage(HttpMethod.Post, "https://api.openai.com/v1/chat/completions");
request.Content = new StringContent(JsonSerializer.Serialize(dto), Encoding.UTF8, "application/json");

using var response = await client.SendAsync(request, HttpCompletionOption.ResponseHeadersRead);

if (!response.IsSuccessStatusCode)
{
    var statusCode = response.StatusCode;
    var reasonPhrase = response.ReasonPhrase;
    var responseContent = await response.Content.ReadAsStringAsync();

    throw new Exception($"Failed to call API. Status code: {statusCode}. Reason phrase: {reasonPhrase}. Response content: {responseContent}");
}
```
