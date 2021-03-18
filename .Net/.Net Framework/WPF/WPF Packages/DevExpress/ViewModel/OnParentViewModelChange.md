# OnParentViewModelChange

假設有 MastView 及 DetailView

- MasterView

  - 要傳遞至 Detail View 的 Property
    - 必須宣告為 virtual
    - 不需要套用 ViewModelBase.SetValue()
  - 引用 ViewModel 的方式必須是 Inline Attribute

- DetailView
  - 套件引用
    - DevExpress.Mvvm;
    - DevExpress.Mvvm.POCO;
  - 必須是 UserControl (Window 未確認是否可行)
  - 引用 ViewModel 的方式必須是 Inline Attribute
  - DetailViewModel
    - 必須實作 ISupportParentViewModel
    - 要做 Property Change 的 Propety 必須宣告為 virtual
