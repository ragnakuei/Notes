# query string 的處理

## 產生不含 url 的 query string

```csharp
var webUrl = "";
var query = HttpUtility.ParseQueryString(webUrl);
query["action"] = "login1";
query["attempts"] = "11";
query.ToString().Dump();
```

執行結果

```txt
action=login1&attempts=11
```

---

## 在現有的 url ( 含 query string ) 再加上 query string 項目

```csharp
var webUrl = "http://localhost:8080/?a=1&b=2";
var uriBuilder = new UriBuilder(webUrl);
var query = HttpUtility.ParseQueryString(uriBuilder.Query);
query["action"] = "login1";
query["attempts"] = "11";
uriBuilder.Query = query.ToString();
uriBuilder.ToString().Dump();
```

執行結果

```txt
http://localhost:8080/?a=1&b=2&action=login1&attempts=11
```
