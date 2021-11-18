# 使用 Response 回應時要注意的

### 避免客戶下載後，出現錯誤訊息： "Excel 已完成檔案層級的驗證和修復。此活頁簿的某些部分可能已經修復或遺失。"

[參考資料](https://ithelp.ithome.com.tw/questions/10206185?sc=nl.daily)

```
MemoryStream 的 GetBuffer 會傳回整個記憶組，包含未使用的。所以 Excel 檔後有一堆 null 位元，造成開啟時判斷為壞檔。試試直接寫入 OutputStream
```

```cs
Response.Clear();
Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
Response.AddHeader("Content-Disposition", string.Format("attachment; filename={0}", saveAsFileName));
workbook.Write(Response.OutputStream);
Response.Flush();
Response.Close();
```
