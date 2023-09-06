# Queue Requests

## Chrome 本身會 Queue 的條件

https://developer.chrome.com/docs/devtools/network/reference/#timing-explanation

### 同時發多個 request 至相同的 url 時，會排隊

https://stackoverflow.com/questions/27513994/chrome-stalls-when-making-multiple-requests-to-same-resource

這個的情況是因為 Cahce 造成的，初步猜測跟上述條件的這句話有關：

> The browser is briefly allocating space in the disk cache
> 