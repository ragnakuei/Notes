# [Bindind Mode](https://docs.microsoft.com/en-us/dotnet/api/system.windows.data.bindingmode)

- Source Proeprty - 資料來源，一般都是 DataContext 的 Property
- Target Property - 目的端，一般都是 UI 端

| enum         | 說明                                              |
| ------------ | ------------------------------------------------- |
| Default      | 各控制項的預設值不同                              |
| OneTime      | 應用程式啟動 或是 DataContext 改變時              |
| OneWay       | Binding Source 改變時。唯讀。                     |
| OneWaySource | 當 Target Property 改變時，會更新 Source Property |
| TwoWay       | 其中一端資料改變時，就會更新另一端的資料          |

---

## OneWaySource Sample

```xml
<Window.DataContext>
    <local:MainViewModel />
</Window.DataContext>

<TextBox Name="Tbx1" Text="{Binding TextBoxValue, UpdateSourceTrigger=PropertyChanged, Mode=TwoWay}" />
<TextBox Name="Tbx2" Text="{Binding TextBoxValue, UpdateSourceTrigger=PropertyChanged, Mode=OneWayToSource}"/>
```

Tbx1 不會更新至 Tbx2，Tbx2 更新至 Tbx1