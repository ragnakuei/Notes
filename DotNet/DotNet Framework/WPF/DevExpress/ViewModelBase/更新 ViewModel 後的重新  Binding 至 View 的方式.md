# 更新 ViewModel 後的重新 Binding 至 View 的方式

[範例](https://github.com/ragnakuei/WpfRebindingFromViewModel)

- 在 AView 裡面
  - 開啟 BWindow
  - 設定 BWindow Close Event
    - 將 BViewModel 內的值抓出來給定至 AViewModel.LabelResult 並要求要重新 Binding 至 AView 上

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
        } }

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
