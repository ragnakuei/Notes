# Enlisting in Ambient transactions is not supported

當以以下語法執行時，就會產生錯誤訊息

```csharp
using (var scope = new TransactionScope(TransactionScopeAsyncFlowOption.Enabled))
using (SqlConnection conn = new SqlConnection(Connection))
{
    
}
```

[解決方式](https://stackoverflow.com/questions/47974837/enlisting-in-ambient-transactions-is-not-supported-using-transactionscope-in-asp)

把參考至 Microsoft.AspNetCore.All 改為參考 System.Data.SqlClient