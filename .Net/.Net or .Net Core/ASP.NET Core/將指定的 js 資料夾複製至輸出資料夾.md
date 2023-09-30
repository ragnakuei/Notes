# 將指定的 js 資料夾複製至輸出資料夾

```xml
  <ItemGroup>
    <Content Include="js\**\*.js">
      <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
    </Content>
  </ItemGroup>
```
