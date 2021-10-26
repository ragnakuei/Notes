# fetch


```js
fetch(url, {
        body: JSON.stringify(requestBody),
        headers: {
            // 讓後端判定 IsAjaxRequest 為 true
            'X-Requested-With' : 'XMLHttpRequest',
            
            'content-type': 'application/json',
            'RequestVerificationToken': '@(GetAntiXsrfRequestToken())',
        },
        method: 'POST',
    });
```