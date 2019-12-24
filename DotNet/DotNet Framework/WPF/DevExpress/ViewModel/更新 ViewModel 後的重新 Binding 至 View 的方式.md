# [更新 ViewModel 後的重新 Binding 至 View 的方式](https://documentation.devexpress.com/WPF/17350/MVVM-Framework/View-Models/BindableBase)

[範例](https://github.com/ragnakuei/WpfSample01)

- 在 AView 裡面

  - 開啟 BWindow
  - 設定 BWindow Close Event
    - 將 BViewModel 內的值抓出來給定至 AViewModel.LabelResult 並要求要重新 Binding 至 AView 上

- 方式一

  透過以下二個其中一個方式來更新

  | method                                              | 說明                  |
  | --------------------------------------------------- | --------------------- |
  | SetValue\<T>(ref field, value, nameof(Property))    |                       |
  | SetProperty\<T>(ref field, value, nameof(Property)) | .Net Framework 4 環境 |

  > 此 Method 還會有第四個引數，用來指定更新值後的 Callback Method

  語法

  1. 透過 BindableBase 儲存值

     ```csharp
     public string LabelResult
     {
         get => GetValue<string>();
         private set => SetValue<string>(value);
     }
     ```

  1. 加上 field

     ```csharp
     private string _labelResult;
     public string LabelResult
     {
         get => _labelResult;
         private set
         {
             if (this.SetValue<string>(ref this._labelResult, value, nameof(LabelResult)))
             {
                 // MessageBox.Show("Success");
             }
             else
             {
                 // MessageBox.Show("Failed");
             }
         }
     }
     ```

- 方式二

  不管是否更新都強制更新，這個可能會導致更頻繁的更新值至 View 上。

  ```csharp
  public class AViewModel : ViewModelBase
  {
      private string _labelResult;
      public string LabelResult
      {
          get => _labelResult;
          private set
          {
              _labelResult = value;

              // 為了重新 Binding 至 View 上
              RaisePropertyChanged(nameof(LabelResult));
          }
      }

      public ICommand OpenBViewCommand { get; set; }

      public AViewModel()
      {
          OpenBViewCommand = new DelegateCommand(OpenBViewEvent, OpenBViewCanEnable);
      }

      private BView _bView;

      private void OpenBViewEvent()
      {
          _bView = new BView
                  {
                      DataContext = new BViewModel()
                  };
          _bView.Closed += BViewClose;
          _bView.Show();
      }

      private bool OpenBViewCanEnable()
      {
          return true;
      }

      private void BViewClose(object sender, EventArgs e)
      {
          var target = sender as DXRibbonWindow;
          LabelResult = (target.DataContext as BViewModel).LabelValue;
      }
  }
  ```
