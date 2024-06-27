# Server-Sent Event

此範例是 投票 功能
SSE 用在投票結果檢視上

投票結果頁面 js

```js
const subscribeUrl = '/api/Home/SubScribe';
const eventSource = new EventSource(subscribeUrl);

function subscribe() {
    eventSource.onopen = function (event) {
        console.log('SSE Open', event);
    };

    eventSource.onmessage = function (event) {
        console.log('onmessage', event);

        const voteResult = JSON.parse(event.data);
        render(voteResult);
    };

    eventSource.addEventListener('notify', (event) => {
        console.log('notify event', event);
        const voteResult = JSON.parse(event.data);
        render(voteResult);
    });

    eventSource.onerror = function (event) {
        console.log('SSE Error', event);
    };
}
```

投票結果頁面 subscribe 後端語法

```js
[HttpGet, Route("api/[Controller]/[Action]")]
public async Task Subscribe(CancellationToken cancellationToken)
{
    HttpContext.Response.Headers.Add("Content-Type",  "text/event-stream");
    HttpContext.Response.Headers.Add("Cache-Control", "no-cache");

    lock (_lock)
    {
        _clients.Add(HttpContext);
    }

    _logger.LogInformation($"Connect");

    // set retry interval
    await HttpContext.Response.WriteAsync("retry: 1000\n\n");

    // 更新目前的資料
    var voteResult     = _voteService.GetVoteResult();
    var voteResultJson = voteResult.ToJson();
    await HttpContext.Response.WriteAsync($"data:{voteResultJson}\n\n");
    await HttpContext.Response.Body.FlushAsync();

    while (!(
                cancellationToken.IsCancellationRequested
             || HttpContext.RequestAborted.IsCancellationRequested
            ))
    {
        await Task.Delay(1000);
    }

    lock (_lock)
    {
        _clients.Remove(HttpContext);
    }

    _logger.LogInformation($"Disconnect");
}

private async Task BroadcastVoteResultAsync()
{
    var voteResult     = _voteService.GetVoteResult();
    var voteResultJson = voteResult.ToJson();

    _logger.LogInformation($"SendMessage:{voteResultJson}");

    foreach (var client in _clients)
    {
        await client.Response.WriteAsync($"event:notify\n");
        await client.Response.WriteAsync($"data:{voteResultJson}\n\n");
        await client.Response.Body.FlushAsync();

        await client.Response.WriteAsync($"data:{voteResultJson}\n\n");
        await client.Response.Body.FlushAsync();
    }
}
```

投票頁面 js

```js
const vote = (id) => {
    fetch('/api/Home/Vote', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            RequestVerificationToken: antiforgery,
        },
        body: JSON.stringify(id),
    })
        .then((res) => res.json())
        .then((res) => {
            alert('投票已完成');
        });
};
```

投票的後端語法

```js
[HttpPost, Route("api/[Controller]/[Action]")]
public async Task<IActionResult> Vote([FromBody]int? id)
{
    _voteService.Vote(id.Value);

    await BroadcastVoteResultAsync();

    return Json(null);
}
```
