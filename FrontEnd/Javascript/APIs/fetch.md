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

        // 影響是否要套用 cross-origin cookie
        // 值為 include 時，會套用 cross-origin cookie
        // 值為 same-origin 時，會套用 same-origin cookie 而不套用 cross-origin cookie
        credentials: 'include',
    })
    .then(response => {

        if (!response.ok) {
            throw response;
        }

        return response.json();
    });
```