# [IConfigurationRoot](https://docs.microsoft.com/zh-tw/dotnet/api/microsoft.extensions.configuration.iconfigurationroot)

## GetChildren()

- 無傳入參數
- 取得根目錄下所有 Section 資料

> json 內的每個節點，不管是 property、array、object ，每個都是 Section 

## GetSection()

- 傳入參數為 section key 或 section path
- configurationRoot.GetSection("key") 等於 `configurationRoot["key"]`
- path 為 B:0:Name ，則代表取出 B 陣列內第一個元素的 Name Property 值
- configurationRoot.GetSection().AsEnumerable() 可以取出所有該 Section Path 內的所有資料
- 以下二個結果不同
  - configurationRoot.GetSection("Key").AsEnumerable()
  - configurationRoot["Key"].AsEnumerable() 
- 以下二個語法效果相同
  - configurationRoot.GetSection("TestFolder:Image")
  - configurationRoot.GetSection("TestFolder).GetSection("Image") 

## 取出指定 Section 的 Array 資料

```json
{
    "TestFolder": {
        "Image" : [ "..", "Image"]
    }
}
```

```csharp
_configuration.GetSection("TestFolder:Image")
              .GetChildren()
              .Select(kv => kv.Value)
```