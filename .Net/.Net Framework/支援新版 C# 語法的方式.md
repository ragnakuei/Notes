# 支援新版 C# 語法的方式

- 預設來說 .net framework 4.8 只支援至 C# 7.3

要讓 .net framework 4.8 可以支援至更高版本的 C# 語法

可以編輯 .csproj 加上以下的語法，就可以了

```xml
<PropertyGroup>
    <LangVersion>latest</LangVersion>
</PropertyGroup>
```

[參考資料](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version#edit-the-project-file)

