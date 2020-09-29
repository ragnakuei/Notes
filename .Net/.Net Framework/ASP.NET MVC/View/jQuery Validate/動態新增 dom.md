# 動態新增 dom

-   [這篇](https://blog.darkthread.net/blog/unobtrusive-jq-vald-dynamic/) 提到，被加入 validate 的時機，是在一開始載入頁面的時候

這篇未完成 !!

如果需要事後進行 validate ，可以透過

```html
<input onclick="TestButtonClick()" type="button" value="Login" />
```

```js
function TestButtonClick() {
    var result = $('#form').valid();
    console.log(result);
}
```

來決定何時要進行 form validate

同時會回傳 form 驗証是否成功
