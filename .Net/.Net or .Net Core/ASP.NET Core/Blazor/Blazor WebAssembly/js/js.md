# js

參考資料

- [Using JS Object References in Blazor WASM to wrap JS libraries](https://blog.elmah.io/using-js-object-references-in-blazor-wasm-to-wrap-js-libraries/)

重點：

1. 二種方式
   1. global object
      1. 
   1. import js
      1. 只能抓到 export function 來執行 !
      1. export object 也無法抓到內部的 function !

