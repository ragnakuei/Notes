# [Secure String](https://docs.microsoft.com/zh-tw/dotnet/api/system.security.securestring)

通常用於將密碼存下來，然後用來呼叫其他的程式，密碼會存在系統上，而不存在程式內

## 使用情境與建議

可參考連結中的以下段落

```
The .NET Framework Class Library commonly uses SecureString instances in the following ways:

-  To provide password information to a process by using the ProcessStartInfo structure or by calling an overload of the Process.Start method that has a parameter of type SecureString.

- To provide network password information by calling a NetworkCredential class constructor that has a parameter of type SecureString or by using the NetworkCredential.SecurePassword property.

- To provide password information for SQL Server Authentication by calling the SqlCredential.SqlCredential constructor or retrieving the value of the SqlCredential.Password property.

- To pass a string to unmanaged code. For more information, see the SecureString and interop section.
```

