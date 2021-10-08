# 讀取 FormData

#### 範例

```cs
public class TestController : ApiController
{
    [HttpGet, Route("Test")]
    public async Task<IHttpActionResult> Get()
    {
        string root = HttpContext.Current.Server.MapPath("~/App_Data");
        var provider = new MultipartFormDataStreamProvider(root);

        var f = await Request.Content.ReadAsMultipartAsync(provider);

        var dto = new TestDto
        {
            Id = Int32.Parse(f.FormData[nameof(TestDto.Id)]),
            Name = f.FormData[nameof(TestDto.Name)],
        };

        return Ok(dto);
    }
}
```