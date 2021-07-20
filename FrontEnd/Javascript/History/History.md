# History

基本動作
- 一進入頁面時，就會預先 pushState，但 state 為 null
- 萬一要存 html，額外存 js 當下的變數資料


## pushState

三個引數
1. state - 自訂要儲存的資料
2. title - 可以直接給定 null
3. url - 可用 window.location.href


