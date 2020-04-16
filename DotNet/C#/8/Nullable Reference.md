# Nullable Reference

- 套用設定後，是指會檢查 null 的判斷，不是指允許 null !
- 影響的部份主要在於明確統一 nullable 與 non-nullable 型態宣告的統一
  - nullable type 宣告就必須以 ? 結尾
  - non-nullable type 宣告就不能以 ? 結尾

## 全域設定方式 1

與 [全域設定方式 2](#%e5%85%a8%e5%9f%9f%e8%a8%ad%e5%ae%9a%e6%96%b9%e5%bc%8f-2)結果相同，只是設定方式不同

project properties > Build > Nullable 下拉選單 > 設定成 `Enable`

## 全域設定方式 2

在 .csproj 中加入

```xml
  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>netcoreapp3.0</TargetFramework>
    <Nullable>enable</Nullable> <!--加入這一行-->
  </PropertyGroup>
```

## 個別檔案設定方式

```csharp
#nullable enable
```

在該檔案上方加入以下語法

- enable - 開啟 nullable 檢查
- disable - 關閉 nullable 檢查

上述設定完畢後，只會在 visual studio 會有 warning 的提示，但不會造成編譯失敗
可參考 [這裡](../../../Tools/Visual%20Studio/讓%20warning%20變成編譯失敗.md) 來調整設定讓 warning 變成編譯失敗

### 指定錯誤 warning 清單

`CS8618,CS8604,CS8600`

## 指定某個區塊設定方式

以 `#nullable enable` 做為區塊起始

以 `#nullable restore` 做為區塊結束

```csharp
#nullable enable
object? o = null;
#nullable restore
```