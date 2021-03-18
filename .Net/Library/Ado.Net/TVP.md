# TVP

## [TVP 導致 SQL 記憶體暴漲](https://dotblogs.com.tw/rockchang/2020/07/16/140443)

重點：

-   DataColumn 可指定 string 最大長度

```vb
Dim cnStr As String
Dim cn As SqlConnection
Dim t As New DataTable

cnStr = "Data Source=127.0.0.1;User Id=apTest; Password=123;Initial Catalog=dbTest"
cn = New SqlConnection(cnStr)
Dim Id, UName, UserId As DataColumn
Id = New DataColumn("Id", System.Type.GetType("System.Int32"))
UName = New DataColumn("UName", System.Type.GetType("System.String"))
UserId = New DataColumn("UserId", System.Type.GetType("System.String"))
UName.MaxLength = 50
UserId.MaxLength = 10

t.Columns.Add(Id)
t.Columns.Add(UName)
t.Columns.Add(UserId)
For i = 0 To 10000 - 1 Step 1
    t.Rows.Add(i, "Rock", "A123456789")
Next
Dim cmd As SqlCommand = cn.CreateCommand
Dim pTVP As SqlParameter
cn.Open()
cmd.CommandType = CommandType.StoredProcedure
cmd.Parameters.Add(New SqlParameter("@Result", ""))
pTVP = cmd.Parameters.Add("@UserList", SqlDbType.Structured)
pTVP.Value = t
pTVP.TypeName = "tvp_tbTarget"
cmd.CommandText = "Usp_UpdateBatch"
Dim reader As SqlDataReader
reader = cmd.ExecuteReader()

cmd.Dispose()
cmd = Nothing
cn.Close()
cn.Dispose()
cn = Nothing
```
