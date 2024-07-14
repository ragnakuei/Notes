# HtmlSanitizer

### 注意事項：

有一個動作是，把整個 html 以 template 字串型式，放到 db 中

同時會用在二個地方：

-   瀏覽器頁面預覽
-   以 html 格式做為信件內容送出

該套件會

-   把 body (含) 以外的所有 tag 全部刪掉
-   inline style 顏色的部份，從 #hhhhhh 轉成 rgb(x,x,x)。這個動作的額外副作用是 瀏覽器 可正常顯示，但信件不行 !
-   同時也會移除 body 內的 style tag !

可調整的大方向是，做出一版經過 Sanitize() 後仍然可以照預期顯示的 html：

-   不能包含 body，只能有內容區塊
-   不能包含 style tag，意指不能有全域設定的方式
-   顯示於頁面時，要經過 Sanitize()，但不針對信件內容過濾 !
