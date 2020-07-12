# [IConfigurationRoot](https://docs.microsoft.com/zh-tw/dotnet/api/microsoft.extensions.configuration.iconfigurationroot)

## GetChildren()

- 無傳入參數
- 取得根目錄下所有 Section 資料

> json 內的每個節點，不管是 property、array、object ，每個都是 Section 

## GetSection()

- 傳入參數為 section key 或 section path
- configurationRoot.GetSection("key") 等於 configurationRoot["key"]
- path 為 B:0:Name ，則代表取出 B 陣列內第一個元素的 Name Property 值
- GetSection().AsEnumerable() 可以取出所有該 Section Path 內的所有資料
