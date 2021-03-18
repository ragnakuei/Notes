# base64

因為相關 method 都是針對 byte[] 處理

```
Convert.ToBase64String(byte[])
```

```
byte[] = Convert.FromBase64String()
```

所以會常常利用 `UnicodeEncoding` 來做 string 與 bytp[] 的轉換

## 範例

```csharp
var data = "一二三123";

var base64string = Convert.ToBase64String(new UnicodeEncoding().GetBytes(data));
base64string.Dump();

var originString = new UnicodeEncoding().GetString(Convert.FromBase64String(base64string));
originString.Dump();
```
