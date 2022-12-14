# 與 js dom 型別互轉

[參考資料](https://www.edureka.co/community/95301/how-can-i-convert-a-dom-element-to-a-jquery-element)


```js
var elm = document.createElement("div");
var jelm = $(elm);//convert to jQuery Element
var htmlElm = jelm[0];//convert to HTML Element
```