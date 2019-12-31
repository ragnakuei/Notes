# [EnumItemsSourceBehavior](https://documentation.devexpress.com/WPF/18089/MVVM-Framework/Behaviors/Predefined-Set/EnumItemsSourceBehavior)

- [EnumItemsSourceBehavior](#enumitemssourcebehavior)
  - [疑難雜症](#%e7%96%91%e9%9b%a3%e9%9b%9c%e7%97%87)
    - [出現 TryGetImageSource Exception](#%e5%87%ba%e7%8f%be-trygetimagesource-exception)

---

## 疑難雜症

### 出現 TryGetImageSource Exception

如果出現以下的 Exception

```log
System.ArgumentException:
  at 於 DevExpress.Mvvm.Native.EnumSourceHelperCore.<>c__DisplayClass10_0.<TryGetImageSource>b__0(String uri)
  at 於 DevExpress.Mvvm.Native.MayBe.With[TI,TR](TI input, Func`2 evaluator)
  at 於 DevExpress.Mvvm.Native.EnumSourceHelperCore.<>c__DisplayClass4_1.<GetEnumSource>b__3()
  at 於 System.Lazy`1.CreateValue()
  at 於 System.Lazy`1.LazyInitValue()
  at 於 System.Lazy`1.get_Value()
  at 於 DevExpress.Mvvm.EnumMemberInfo.get_Image()
```

原因是因為指定的 Enum Image，圖片指定的路徑是專案下的絕對路徑，要記得設定在編譯時要 COPY 至輸出目錄
