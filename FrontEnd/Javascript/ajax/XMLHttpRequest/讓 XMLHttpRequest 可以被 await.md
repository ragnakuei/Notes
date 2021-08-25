# 讓 XMLHttpRequest 可以被 await

因為 XMLHttpRequest 無法套用 await

當包裝成 Promise 後，就可以搭配 await 了 !

## 範例

### 未套用可 await 前

```js
function uploadComplete(chunk_guid) {
    const complete_request = new XMLHttpRequest();
    complete_request.onload = function () {
        const response_dto = JSON.parse(complete_request.response);
        if (response_dto.IsValid) {
            // something
        }
    };
    complete_request.open("POST", upload_chunk_complete_url, true);
    complete_request.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
    complete_request.send(JSON.stringify(chunk_guid));
}

uploadComplete(chunk_guid);
```

### 套用可 await 後

```js
function upload_complete_promise(url, request_body) {
    return new Promise(resolve => {

        const complete_request = new XMLHttpRequest();

        complete_request.onload = function () {
            resolve(complete_request.response);
        };

        complete_request.onerror = function () {
            resolve(undefined);
            console.error("** An error occurred during the XMLHttpRequest");
        };

        complete_request.open("POST", url, true);
        complete_request.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
        complete_request.send(request_body);
    })
}

await upload_complete_promise(chunk_guid)
      .then(response => {
          const response_dto = JSON.parse(response);
          if (response_dto.IsValid) {
              // something
          }
      })
```