# error CS0012: The type 'ValueType' is defined in an assembly that is not referenced.

---

### 發生情境

當套用以下 [語法](https://www.notion.so/DisplayName-9fb168d145494b47b5ccb25b10d91e45#8bd54ab7d40046fd9732b4a0771090cc) 時，就會發生

### 解法

加上圖中 `assemblies` ******底線的部份

```html
<system.web>
    <authentication mode="Forms">
        <forms defaultUrl="~/Home/Index/" loginUrl="~/Auth/Login/" timeout="30" />
    </authentication>
    <compilation debug="true" targetFramework="4.8">
        *<assemblies>
            <add assembly="netstandard, Version=2.0.0.0, Culture=neutral, PublicKeyToken=cc7b13ffcd2ddd51" />
        </assemblies>*
    </compilation>
    <httpRuntime targetFramework="4.8" />
</system.web>
```

[error CS0012: The type 'ValueType' is defined in an assembly that is not referenced. · Issue #1560 · xunit/xunit](https://github.com/xunit/xunit/issues/1560)