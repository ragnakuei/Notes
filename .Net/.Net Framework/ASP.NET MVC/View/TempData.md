# TempData

生命週期是在 Request 內，所以當 Redirect 至其他頁面時，還是可以抓出資料的 !

使用 

- RedirectResult
- RedirectToRouteResult

依然可以保留 TempDate 內的值