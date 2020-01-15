# Debug

- [Debug](#debug)
  - [Binding 時，找對應的 DataContext](#binding-%e6%99%82%e6%89%be%e5%b0%8d%e6%87%89%e7%9a%84-datacontext)
  - [Binding 時，找不到對應的 DataContext](#binding-%e6%99%82%e6%89%be%e4%b8%8d%e5%88%b0%e5%b0%8d%e6%87%89%e7%9a%84-datacontext)
  - [觸發 PropertyChanged 事件](#%e8%a7%b8%e7%99%bc-propertychanged-%e4%ba%8b%e4%bb%b6)

---

在 Binding 時，加上語法 `PresentationTraceSources.TraceLevel=High`

```xml
<TextBlock Text="{Binding Title, PresentationTraceSources.TraceLevel=High}" />
```

---

## Binding 時，找對應的 DataContext

Output 會有以下訊息

```log
System.Windows.Data Warning: 56 : Created BindingExpression (hash=46212239) for Binding (hash=27504314)
System.Windows.Data Warning: 58 :  Path: 'Title'
System.Windows.Data Warning: 60 : BindingExpression (hash=46212239): Default mode resolved to OneWay
System.Windows.Data Warning: 61 : BindingExpression (hash=46212239): Default update trigger resolved to PropertyChanged
System.Windows.Data Warning: 62 : BindingExpression (hash=46212239): Attach to System.Windows.Controls.TextBlock.Text (hash=54778057)
System.Windows.Data Warning: 67 : BindingExpression (hash=46212239): Resolving source
System.Windows.Data Warning: 70 : BindingExpression (hash=46212239): Found data context element: TextBlock (hash=54778057) (OK)
System.Windows.Data Warning: 78 : BindingExpression (hash=46212239): Activate with root item MainViewModel (hash=23240469)
System.Windows.Data Warning: 108 : BindingExpression (hash=46212239):   At level 0 - for MainViewModel.Title found accessor ReflectPropertyDescriptor(Title)
System.Windows.Data Warning: 104 : BindingExpression (hash=46212239): Replace item at level 0 with MainViewModel (hash=23240469), using accessor ReflectPropertyDescriptor(Title)
System.Windows.Data Warning: 101 : BindingExpression (hash=46212239): GetValue at level 0 from MainViewModel (hash=23240469) using ReflectPropertyDescriptor(Title): 'Main Window Title'
System.Windows.Data Warning: 80 : BindingExpression (hash=46212239): TransferValue - got raw value 'Main Window Title'
System.Windows.Data Warning: 89 : BindingExpression (hash=46212239): TransferValue - using final value 'Main Window Title'
```

---

## Binding 時，找不到對應的 DataContext

Output 會有以下訊息

```log
System.Windows.Data Warning: 56 : Created BindingExpression (hash=3056034) for Binding (hash=37320431)
System.Windows.Data Warning: 58 :  Path: 'Title'
System.Windows.Data Warning: 60 : BindingExpression (hash=3056034): Default mode resolved to OneWay
System.Windows.Data Warning: 61 : BindingExpression (hash=3056034): Default update trigger resolved to PropertyChanged
System.Windows.Data Warning: 62 : BindingExpression (hash=3056034): Attach to System.Windows.Controls.TextBlock.Text (hash=63642613)
System.Windows.Data Warning: 67 : BindingExpression (hash=3056034): Resolving source
System.Windows.Data Warning: 70 : BindingExpression (hash=3056034): Found data context element: TextBlock (hash=63642613) (OK)
System.Windows.Data Warning: 71 : BindingExpression (hash=3056034): DataContext is null
System.Windows.Data Warning: 67 : BindingExpression (hash=3056034): Resolving source
System.Windows.Data Warning: 70 : BindingExpression (hash=3056034): Found data context element: TextBlock (hash=63642613) (OK)
System.Windows.Data Warning: 71 : BindingExpression (hash=3056034): DataContext is null
System.Windows.Data Warning: 67 : BindingExpression (hash=3056034): Resolving source  (last chance)
System.Windows.Data Warning: 70 : BindingExpression (hash=3056034): Found data context element: TextBlock (hash=63642613) (OK)
System.Windows.Data Warning: 78 : BindingExpression (hash=3056034): Activate with root item <null>
System.Windows.Data Warning: 106 : BindingExpression (hash=3056034):   Item at level 0 is null - no accessor
System.Windows.Data Warning: 80 : BindingExpression (hash=3056034): TransferValue - got raw value {DependencyProperty.UnsetValue}
System.Windows.Data Warning: 88 : BindingExpression (hash=3056034): TransferValue - using fallback/default value ''
System.Windows.Data Warning: 89 : BindingExpression (hash=3056034): TransferValue - using final value ''
```

## 觸發 PropertyChanged 事件

Output 會有以下訊息

```log
System.Windows.Data Warning: 96 : BindingExpression (hash=50315352): Got PropertyChanged event from TextBox (hash=50184984) for DataContext
System.Windows.Data Warning: 79 : BindingExpression (hash=50315352): Deactivate
System.Windows.Data Warning: 103 : BindingExpression (hash=50315352): Replace item at level 0 with {NullDataItem}
System.Windows.Data Warning: 78 : BindingExpression (hash=50315352): Activate with root item MainWindow (hash=36842478)
System.Windows.Data Warning: 108 : BindingExpression (hash=50315352):   At level 0 - for MainWindow.Width found accessor DependencyProperty(Width)
System.Windows.Data Warning: 104 : BindingExpression (hash=50315352): Replace item at level 0 with MainWindow (hash=36842478), using accessor DependencyProperty(Width)
System.Windows.Data Warning: 101 : BindingExpression (hash=50315352): GetValue at level 0 from MainWindow (hash=36842478) using DependencyProperty(Width): '800'
System.Windows.Data Warning: 80 : BindingExpression (hash=50315352): TransferValue - got raw value '800'
System.Windows.Data Warning: 84 : BindingExpression (hash=50315352): TransferValue - implicit converter produced '800'
System.Windows.Data Warning: 89 : BindingExpression (hash=50315352): TransferValue - using final value '800'
```
