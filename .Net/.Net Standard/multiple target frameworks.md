# multiple target frameworks

可讓 .net standard 擴充支援更多版本的 .net framework !

從 [Target Framework Monikers](https://docs.microsoft.com/en-us/dotnet/standard/frameworks) 可取出對應的 .net framework 的 TFMs 

就可以放在 .csproj 的 TargetFrameworks 中

## 切換 IDE 的 target framework

Visual Studio - 在程式碼編輯器左上角  
Jetbrains Rider - 在右下角的訊息列最左邊

## 使用 前置處理器指示詞 (preprocessor-directives) 範例

```csharp
public class Class1
{
    public string Get()
    {
        #if NET45
        return "Hello World DotNet Framework 45";
        #else
        return "Hello World DotNet Standard 20";
        #endif
    }
}
```

## 引用非 .Net Standard 2.0 組件參考

透過 [MSBuild conditional constructs](https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild-conditional-constructs?view=vs-2019) 來達成

編輯 .net standard 2.0 的 .csproj 

```xml
<Project Sdk="Microsoft.NET.Sdk">

    <PropertyGroup>
        <TargetFrameworks>netstandard2.0;net45</TargetFrameworks>
    </PropertyGroup>
    
    <ItemGroup Condition="'$(TargetFramework)' == 'net45'">
        <Reference Include="System.Net.Http" />
    </ItemGroup>

</Project>
```
