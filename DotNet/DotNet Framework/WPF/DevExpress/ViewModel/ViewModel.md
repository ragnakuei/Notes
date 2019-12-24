# [ViewModel](https://documentation.devexpress.com/WPF/17439/MVVM-Framework/View-Models)

在 MVVM 架構下，負責 View 跟 Model 的間的處理

- DevExpress MVVM 提供了二個 BaseClass

  - [BindableBase](https://documentation.devexpress.com/WPF/17350/MVVM-Framework/View-Models/BindableBase) - 實作了 INotifyPropertyChanged 讓你以最小量的 Code 來處理綁定 Properties
  - [ViewModelBase](https://documentation.devexpress.com/WPF/17351/MVVM-Framework/View-Models/ViewModelBase) - 繼承了 BindableBase，並提供了 Command、Service、與 View Model 構通

- [POCO View Models](https://documentation.devexpress.com/WPF/17352/MVVM-Framework/View-Models/POCO-ViewModels)

  - 以 ViewModelSource.Create() 的方式來建立 ViewModel

---

## BindableBase

- 以 Get\<T>、Set\<T> 來取代原本 Accessor 的功能

  ```csharp
  public class ViewModel : BindableBase {
      public string FirstName {
          get { return GetValue<string>(nameof(FirstName)); }
          set { SetValue(value, nameof(FirstName)); }
      }
  }
  ```

- Set\<T> 回傳 bool，在設定值成功之後，就會回傳 true

  可用來在值更新後，給定要執行的動作

  ```csharp
  using DevExpress.Mvvm;

  public class ViewModel : BindableBase {
      public string FirstName {
          get { return GetValue<string>(); }
          set {
              if (SetValue(value))
              {
                  // 值更新後所需要執行的動作
                  NotifyFullNameChanged();
              }
              else MessageBox.Show("Could not change value!");
          }
      }
  }
  ```

- 利用 Set\<T> 的 Callback Method 來處理值更新後所需要執行的動作

  可用來在值更新後，給定要執行的動作

  ```csharp
    using DevExpress.Mvvm;

    public class ViewModel : BindableBase {
        public string FirstName {
            get { return GetValue<string>(); }
            set { SetValue(value, changedCallback: OnFirstNameChanged); }
        }

        void OnFirstNameChanged() {
        //...
        }
    }
  ```
