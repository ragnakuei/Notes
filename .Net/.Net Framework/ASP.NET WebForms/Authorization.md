# Authorization

## 透過 Web.config 來指定

- 一定要 deny users="?"，否則仍然會允許 anonymous users !

```xml
<system.web>
    <authorization>
        <deny users="?" />
        <allow roles="Manage" />
    </authorization>
</system.web>
```