# DOM object 與 jquery object 間的轉換

從 DOM object 轉成 jquery object

```js
var jqueryObj = $(domObj);
```

從 jquery object 轉成 DOM object

```js
var domObj = $(domObj).get();
```

注意：
> jQuery 很容易取得集合資料，所以要正確比對可以用以下語法

```js
clickedDom1.get()[0] === clickedDom2
clickedDom1[0] === $(clickedDom2)[0]
```

[參考資料](https://howtodoinjava.com/jquery/javascript-dom-objects-vs-jquery-objects/)
