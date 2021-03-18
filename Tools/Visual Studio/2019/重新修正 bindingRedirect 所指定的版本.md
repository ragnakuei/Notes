
執行以下指令：
```
Get-Project –All | Add-BindingRedirect
```

原理：
> 判斷 .csproj 中的 套件 Version 所指定的版本來更新 組態檔

建議還是要看一下該版本指定的 dll 檔是否正確，避免出錯 !

參考資料：

- https://weblog.west-wind.com/posts/2014/nov/29/updating-assembly-redirects-with-nuget

- https://tech.trailmax.info/2013/09/assembly-version-mismatch-and-bulk-package-update/
