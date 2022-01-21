# 將 callback function 轉為 Promsie

## 範例一

callback function 為 `onload` 、 `onerror` !

```js
function create_resumeable_promise(url, request_body) {
    return new Promise((resolve) => {
        const get_chunk_request = new XMLHttpRequest();

        get_chunk_request.onload = function () {
            resolve(JSON.parse(get_chunk_request.response));
        };

        get_chunk_request.onerror = function () {
            resolve(undefined);
            console.error('** An error occurred during the XMLHttpRequest');
        };

        get_chunk_request.open('POST', url, true);
        get_chunk_request.setRequestHeader(
            'Content-Type',
            'application/json;charset=UTF-8',
        );
        get_chunk_request.send(request_body);
    });
}
```

同時也可以讓 create_resumeable_promise 變成 async !
