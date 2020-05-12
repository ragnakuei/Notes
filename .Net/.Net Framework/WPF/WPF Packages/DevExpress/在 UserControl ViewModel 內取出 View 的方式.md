# 在 UserControl ViewModel 內取出 View 的方式

透過 ICurrentWindowServide 轉成 CurrentWindowService 的 AssociatedObject 轉成 View Class 就可以了 !

```csharp
private ICurrentWindowService CurrentWindowService => GetService<ICurrentWindowService>();

private SideView View => ( CurrentWindowService as CurrentWindowService )?.AssociatedObject as SideView;
```

      