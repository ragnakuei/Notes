# Service Injection

流程

1. 在 View 宣告了需要 Injection 的子類

1. 在 View 裡面註冊了使用的 DataContext ViewModel

1. ViewModel 直接透過 Service Injection 來取得 interface 所實作的 instance
