# 透過 ajax 後端資料來 import


```js
// 回傳型別是 Promise
async function importFromBackend(method, url, data) {

    pubSubService.publish('showLoadingSpinner');

    const fetchOption = {
        method: method,
        headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'RequestVerificationToken': window.antifogeryToken,
        },
    };

    if ( method.toLowerCase() === 'get' ) {
        
        // 如果有 id，就把 id 放在 url 後面，以符合 RESTful API 的規範
        if(data['id']) {
            url = url + '/' + data['id'];
            delete data['id'];
        }
        
        url = url + '?' + new URLSearchParams(data).toString();
    } else {
        fetchOption.body = JSON.stringify(data);
    }


    const response = await fetch(url, fetchOption);

    try {

        if(!response.ok) {
            return Promise.reject(response);
        }
        
        const blob = await response.blob();
        const url = URL.createObjectURL(blob);
        const module = await import(url);
        URL.revokeObjectURL(url); // GC objectURLs
        return await module;
        
    } finally {
        setTimeout(() => {
            pubSubService.publish('hideLoadingSpinner');
        }, 500);
    }
}
```
