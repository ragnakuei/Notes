# BaseViewModel

參考 [這裡](https://www.notion.so/WPF-MVVM-998fe52561874f6f912ec703148dec0e) 的實作

```csharp
public class ViewModelBase : INotifyPropertyChanged
{
    public event PropertyChangedEventHandler PropertyChanged;
 
    protected void OnPropertyChanged(
        [CallerMemberName]string PropertyName = null)
    {
        if (PropertyName != null)
        {
            PropertyChanged(this,
                            new PropertyChangedEventArgs(PropertyName));
        }
    }
}
```