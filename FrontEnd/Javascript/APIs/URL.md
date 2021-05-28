# [URL](https://developer.mozilla.org/zh-TW/docs/Web/API/URL)

```js
var testUrl = new URL('https://localhost:44384/News?a=1&b=2');

console.log(testUrl);
console.log(testUrl.href, 'href');
console.log(testUrl.hostname , 'hostname');
console.log(testUrl.pathname, 'pathname');
console.log(testUrl.protocol, 'protocol');
console.log(testUrl.search, 'search');
console.log(testUrl.searchParams, 'searchParams');

for (let pair of testUrl.searchParams.entries()) {
  console.log(`key: ${pair[0]}, value: ${pair[1]}`)
}
```


## 產生 Query String 的方式

下面結果都相同

```js
// 方法一：直接寫入
let searchParams = new URLSearchParams('a=1&b=2');
console.log(searchParams.toString());

// 方法二：代入陣列
searchParams = new URLSearchParams([['a', '1'], ['b', '2']]);
console.log(searchParams.toString());

// 方法三：代入物件
searchParams = new URLSearchParams({a: '1', b: '2'});
console.log(searchParams.toString());
```