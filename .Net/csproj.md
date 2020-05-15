# csproj

- [csproj](#csproj)
  - [把指定資料加入專案中，並在編譯時，保留最新的版本](#%e6%8a%8a%e6%8c%87%e5%ae%9a%e8%b3%87%e6%96%99%e5%8a%a0%e5%85%a5%e5%b0%88%e6%a1%88%e4%b8%ad%e4%b8%a6%e5%9c%a8%e7%b7%a8%e8%ad%af%e6%99%82%e4%bf%9d%e7%95%99%e6%9c%80%e6%96%b0%e7%9a%84%e7%89%88%e6%9c%ac)

## 把指定資料加入專案中，並在編譯時，保留最新的版本

```xml
<ItemGroup>
    <Content Include="Python\**\*.*" CopyToOutputDirectory="PreserveNewest" />
</ItemGroup>
```
