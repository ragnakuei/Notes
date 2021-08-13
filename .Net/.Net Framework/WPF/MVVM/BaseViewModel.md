# BaseViewModel

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