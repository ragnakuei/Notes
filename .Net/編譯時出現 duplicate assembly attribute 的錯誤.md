# 編譯時出現 duplicate assembly attribute 的錯誤

```log
'System.Reflection.AssemblyCompanyAttribute' 屬性重複
'System.Reflection.AssemblyConfigurationAttribute' 屬性重複
'System.Reflection.AssemblyfileversionAttribute' 屬性重複
'System.Reflection.Assembly/informationalVersionAttribute' 屬性重複
'System. Reflection.AssemblyProductAttribute' 屬性重複
'System.Reflection.AssemblyTitleAttribute' 屬性重複
'System.Reflection.AssemblyversionAttribute' 屬性重複
```

原因：

只要專案目錄內有二個以上的 obj 資料夾，就會產生此錯誤
已知二個比較有可能的情境：
1. 專案資料夾內，還有其他的專案資料夾
1. 使用 AI 時，會在 Test Cases 指定檔案中，產生 obj 資料夾，用來測試產生的 Test Case 是否有問題需要修正 !