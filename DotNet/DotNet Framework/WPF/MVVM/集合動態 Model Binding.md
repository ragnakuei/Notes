# 集合動態 Model Binding

二個重點

- ViewModel 要實作 INotifyPropertyChanged
- 原本 List\<T> 的集合，要改用 ObservableCollection\<T>

```csharp
public class 自動技能ViewModel : INotifyPropertyChanged
{
    public 自動技能ViewModel()
    {
        新增自動技能Command = new BaseCommand(自動技能OnClickExecute);
    }

    public ICommand 新增自動技能Command { get; set; }
    public ICommand 刪除自動技能Command { get; set; }

    private void 自動技能OnClickExecute()
    {
        自動技能s.Add(new 自動技能
                    {
                        Id = 自動技能s.Select(a => a.Id)
                                .DefaultIfEmpty(0)
                                .Max() + 1
                    });
    }

    public BoxDTO BoxDTO { get; set; }

    #region INotifyPropertyChanged Members

    private ObservableCollection<自動技能> _自動技能s;
    public ObservableCollection<自動技能> 自動技能s
    {
        get => _自動技能s;
        set
        {
            _自動技能s = value;
            OnPropertyChanged(nameof(自動技能s));
        }
    }

    public event PropertyChangedEventHandler PropertyChanged;

    private void OnPropertyChanged(string propertyName)
    {
        if (PropertyChanged != null)
        {
            PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
        }
    }

    #endregion
}
```