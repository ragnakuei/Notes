# 防止 CSRF

一般用於 HttpPost，有二個部份要實作

### Controller / Action

在 action 的 attribute 加上

只能從 content-type form-data / x-www-form-urlencoded 來讀取資料，無法從 json 取出 __RequestVerificationToken 取出 !

```jsx
[ValidateAntiForgeryToken]
```

### View

在 form 裡面加上 

```jsx
@Html.AntiForgeryToken()
```