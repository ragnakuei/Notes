# XSS

原因：
以下面幾個 API，去將後端回傳的 html 直接放進 DOM 中

-   jQuery.html()
-   Node.appendChild()

### 騙 Checkmarx 的解法：

1. 建立假的 DOMPurify.sanitize()，只回傳原先傳入的 html !

    這個做法並未如實解決風險 !

    ```js
    window.DOMPurify = {
        sanitize: function (html) {
            return html;
        },
    };

    const clean = DOMPurify.sanitize('<s>hello</s>');
    ```

### 最佳解法：

-   實際安裝 DOMPurify 套件去過濾 html
-   ajax 回傳資料結構以 json / xml 為主，在 js 中以 .textContent 或 jQuery.text() 來將值放入 DOM 中

註：

-   Rich Text Editor 的顯示需求，目前似乎只能透過 DOMPurify 來過濾 !
