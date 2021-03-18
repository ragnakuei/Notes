# MVVM

天空的垃圾場 WPF

1. http://blog.sanc.idv.tw/2011/12/wpf-mvvm.html
1. http://blog.sanc.idv.tw/2011/12/wpf-mvvm_29.html
1. http://blog.sanc.idv.tw/2011/12/wpf-mvvm_31.html

https://docs.microsoft.com/en-us/previous-versions/msp-n-p/hh848246(v=pandp.10)

https://docs.microsoft.com/en-us/archive/msdn-magazine/2009/february/patterns-wpf-apps-with-the-model-view-viewmodel-design-pattern

https://docs.microsoft.com/en-us/archive/msdn-magazine/2014/april/mvvm-multithreading-and-dispatching-in-mvvm-applications

## 生命週期

### 觀念 1

    假設需要在 ViewModel 內給定 GridView 初始值，在建構子中給定，可以不需要透過 Property Change 事件去做綁定。

    但是如果在 OnLoad 中給定初始值時，就需要透過 Property Change 事件去做綁定。

    初步判斷是經過建構子初始化後，就已經完成 Binding 的動作，所以就必須透過 Property Change 來通知 View 來更新內容。
