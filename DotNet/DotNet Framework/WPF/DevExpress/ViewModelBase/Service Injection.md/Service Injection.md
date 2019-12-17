# [Service Injection](https://documentation.devexpress.com/WPF/17414/MVVM-Framework/Services)

流程

1. 宣告 IServier 及實作 Service

1. 實作 Service 要承 `ViewServiceBase`

1. 在 View 宣告了需要 Injection 的子類

1. 在 View 裡面註冊了使用的 DataContext ViewModel

1. ViewModel 繼承 `ViewModelBase`

1. ViewModel 直接透過 Service Injection 來取得 interface 所實作的 instance
