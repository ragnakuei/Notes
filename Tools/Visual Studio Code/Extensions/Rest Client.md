# Rest Client.md

- vsocde Language Mode 要選擇 `http`
- 輸入內容
- 右鍵選單，會有一個 send request 項目，來發迗 request

## 送出 Request 範例

### multipart/form-data

```http
POST https://localhost:5001/Test HTTP/1.1
Content-Type: multipart/form-data; boundary=--------------------------196069350060954722912754
Content-Length: 512

----------------------------196069350060954722912754
Content-Disposition: form-data; name="AList[0][id]"

 1
----------------------------196069350060954722912754
Content-Disposition: form-data; name="AList[0][name]"

 A
----------------------------196069350060954722912754
Content-Disposition: form-data; name="AList[1][id]"

 2
----------------------------196069350060954722912754
Content-Disposition: form-data; name="AList[1][name]"

 B
----------------------------196069350060954722912754--
```

