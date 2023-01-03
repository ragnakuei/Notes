# Chrome

## 會依序執行來自相同頁面跟相同 target api 的 request，而不會平行執行

https://stackoverflow.com/questions/27513994/chrome-stalls-when-making-multiple-requests-to-same-resource

## 清除 HSTS Domain

> chrome://net-internals/#hsts

找到 Delete domain security policies

輸入指定的 Domain (不包含 port) ，按下 Delete 即可
