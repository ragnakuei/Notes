# 傳值至 js 要注意的地方

#### 防止 xss

預設來說 html helper 會做 html encode 的動作

但是直接把值放到 js 變數中時，最好不要加上 Html.Raw，以避免 xss 攻擊

最好還是透過 ajax 來跟後端溝通
