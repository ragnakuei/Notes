# 在編譯後_移除相依套件的 dll

## [Chisel](https://github.com/0xced/Chisel)

### [移除 Microsoft.Data.SqlClient 所相依的 Azure.Identity 套件](https://github.com/0xced/Chisel?tab=readme-ov-file#removing-the-azure-sdk-from-microsoftdatasqlclient-version-6)

1. 安裝 Nuget 套件 Chisel
1. .csproj 相關的設定如下

```xml
<ItemGroup>
    <PackageReference Include="Dapper" Version="2.1.35" />
    <PackageReference Include="Microsoft.Data.SqlClient" Version="5.2.0" />

    <!-- 安裝的套件 -->
    <PackageReference Include="Chisel" Version="1.1.2">
        <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
        <PrivateAssets>all</PrivateAssets>
    </PackageReference>
</ItemGroup>

<ItemGroup>
    <!-- 要被 Chisel 於編譯後移除的套件 -->
    <ChiselPackage Include="Azure.Identity" />
</ItemGroup>
```