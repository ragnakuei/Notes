


範例
```csharp
private readonly string BaseUri = "http://www.test.com";
private readonly string ContentType = "application/json";
private readonly string Authorization = "";

async Task Main()
{
	var count = 31;
	var tasks = new Task<(HttpStatusCode, Response400)>[count];
	var startDate = new DateTime(2019,1,1);
	for (int i = 0; i < count; i++)
	{
		var queryDate = startDate.AddDays(i);
		var relativePath = $"api/xxx?date={queryDate.ToString("yyyy/MM/dd")}";
		tasks[i] = SendAsync<Response400>(relativePath);
	}

	var allResults = await Task.WhenAll(tasks);
	allResults.Dump();
}

public async Task<(HttpStatusCode HttpStatusCode, T ResponseBody)> SendAsync<T>(string relativePath)
{
	HttpClient client = new HttpClient(new HttpClientHandler { UseProxy = false });
	client.BaseAddress = new Uri(BaseUri);
	client.DefaultRequestHeaders.Add("Authorization", Authorization);
	client.DefaultRequestHeaders.Add("Accept-Language", "zh-tw");
	client.DefaultRequestHeaders.Add("FunctionCode", "InterfaceEventLog");
	client.DefaultRequestHeaders.Add("ActionCode", "Default");

	HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Post, relativePath);
	request.Content = new StringContent(GetRequestBody(), Encoding.UTF8,ContentType);

	var responseMessage = await client.SendAsync(request);
	var responseContent = (await responseMessage.Content.ReadAsStringAsync());
	var responseBody = responseContent.DeserialzeJson<T>();
	
	return(HttpStatusCode : responseMessage.StatusCode, ResponseBody : responseBody);
}

private string GetRequestBody()
{
	return string.Empty;
}

public class Response400
{
	public Response400Meta Meta { get; set; }
	public Response400Error Error { get; set; }
}

public class Response400Meta
{
	public string HttpStatusCode { get; set; }
}

public class Response400Error
{
	public string Status { get; set; }
	public string Title { get; set; }
	public string Detail { get; set; }
	public string MulitiDetail { get; set; }
}
```
