# [ajax](http://www.jquery-bootgrid.com/Examples#data-api)

- [ajax](#ajax)
  - [分頁](#%e5%88%86%e9%a0%81)
    - [request 欄位](#request-%e6%ac%84%e4%bd%8d)
    - [response 格式](#response-%e6%a0%bc%e5%bc%8f)
  - [增加額外的 query string field](#%e5%a2%9e%e5%8a%a0%e9%a1%8d%e5%a4%96%e7%9a%84-query-string-field)

---

## 分頁

- base 1

### request 欄位

- Get - 會把以下欄位放到 query string 中
- Post - 會把以下欄位放到 request body 中

| 欄位名稱 | 說明             |
| -------- | ---------------- |
| current  | 所在頁碼，base 1 |
| rowCount | 一頁幾筆         |

### response 格式

```json
{
  "current": 1,
  "rowCount": 10,
  "rows": [
    {
      "id": 19,
      "sender": "123@test.de",
      "received": "2014-05-30T22:15:00"
    },
    {
      "id": 14,
      "sender": "123@test.de",
      "received": "2014-05-30T20:15:00"
    }
  ],
  "total": 1123
}
```

---

## [增加額外的 query string field](https://stackoverflow.com/questions/25059751/loading-internal-json-data-to-bootgrid)

- 以 GET 方式取資料
- 給定 post 的物件內容來增加 field

```js
$("#orderList").bootgrid({
  navigation: 3,
  ajaxSettings: {
    method: "GET",
    cache: false
  },
  ajax: true,
  post: function() {
    return {
      pageIndex: $("#orderList").bootgrid("getCurrentPage"),
      pageSize: $("#orderList").bootgrid("getRowCount")
    };
  },
  url: "/api/order/list"
});
```
