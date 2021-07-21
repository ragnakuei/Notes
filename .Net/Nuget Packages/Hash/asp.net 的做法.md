# asp.net 的做法

```csharp
FormsAuthentication.HashPasswordForStoringInConfigFile(password + _salt, "SHA256");
```