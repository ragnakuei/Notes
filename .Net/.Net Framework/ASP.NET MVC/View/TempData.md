# TempData

- 生命週期是在 Request 內，所以當 Redirect 至其他頁面時，還是可以抓出資料的 !
- 可以跨 Action
- 可以跨 Controller、View
- 預設是讀取後，就消失了
- 可以使用 TempData.Keep(key) 來多保留下一次讀取不會消失

使用 

- RedirectResult
- RedirectToRouteResult

依然可以保留 TempDate 內的值

