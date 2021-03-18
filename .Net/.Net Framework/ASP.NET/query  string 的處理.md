# query string 的處理

[參考資料](https://blog.darkthread.net/blog/httpvaluecollection-tostring-urlencode)

透過 HttpUtility.ParseQueryString() 才會得到 `HttpQSCollection` instance 型別，但是該型別無法被外部使用

在外部只能以 `NameValueCollection` 名稱來表示

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

## 與 Path 結合處理

```csharp
var host = new UriBuilder("https://localhost:5001/");

host.Path = Path.Combine("/a", "b", "c");

var queryString = HttpUtility.ParseQueryString(string.Empty);
queryString["WorkId"] = Guid.NewGuid().ToString();

host.Query = queryString?.ToString();

host.ToString().Dump();
```

執行結果

```
https://localhost:5001/a/b/c?WorkId=68a149c8-6c5c-4132-9fc3-711f4e78e2b5
```
