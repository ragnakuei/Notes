# 取得 text/html 內容

```js
const requestBody = new URLSearchParams();
requestBody.append('index', ItemsCount);

fetch(AddItemUrl, {
    method: 'POST',
    mode: 'cors',
    cache: 'no-cache',
    credentials: 'same-origin',
    headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
    },
    referrerPolicy: 'no-referrer',
    body: requestBody,
    })
.then(response => response.text())
.then(data => {
    $('#Items').append(data);
})
```