# 使用 filter

1.  要以 ?$filter= 開頭
2.  不需要做 UrlEncode
3.  Property Path 以 / 分隔
4.  值以 單引號 包起來

### 範例 01

subject 以 Test4 開頭

```
https://graph.microsoft.com/v1.0/users/b0202e1f-0334-4f1f-b9c5-6cf99bc550df/Events/?$filter=startswith(subject,'Test4')
```

start.dateTime 大於等於 指定時間

```
https://graph.microsoft.com/v1.0/users/b0202e1f-0334-4f1f-b9c5-6cf99bc550df/Events/?$filter=start/dateTime ge '2022-05-20'
```
