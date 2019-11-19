# Nullable Reference

全域設定方式

在 .csproj 中加入

```xml
  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>netcoreapp3.0</TargetFramework>
    <Nullable>enable</Nullable> <!--加入這一行-->
  </PropertyGroup>
```

個別檔案設定方式

在該檔案上方加入以下語法

- enable - 開啟 nullable 檢查
- disable - 關閉 nullable 檢查

```csharp
#nullable enable
```

上述設定完畢後，只會在 visual studio 會有 warning 的提示，但不會造成編譯失敗
可參考 [這裡](../../../Tools/Visual%20Studio/讓%20warning%20變成編譯失敗.md) 來調整設定讓 warning 變成編譯失敗
