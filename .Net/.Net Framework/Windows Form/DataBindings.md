# DataBindings

## 範例一

當 Property 是透過 Timer 來更新時，如果不透過 INotifyPropertyChanged.PropertyChanged，會發現 DataBindings 並不會自動更新。

以下範例是透過 Timer 來更新 Now Property，同時會呼叫 INotifyPropertyChanged.PropertyChanged 事件，這樣 DataBindings 才會自動更新。

Form1.cs

```cs
public partial class Form1 : Form
{
    private readonly NowTimeService _nowTimeService;

    public Form1()
    {
        InitializeComponent();
        _nowTimeService = new NowTimeService();
    }

    private void Form1_Load(object sender, EventArgs e)
    {
        _nowTimeService.EnableTimer();

        lblNow.DataBindings.Add("Text", _nowTimeService, "Now");
    }
}
```

```cs
public class NowTimeService : INotifyPropertyChanged
{
    public void EnableTimer()
    {
        _timer          =  new Timer();
        _timer.Interval =  1000;
        _timer.Tick     += new EventHandler(TimerTick);
        _timer.Start();
    }

    private Timer _timer;

    private string _now;

    public string Now
    {
        get => _now;
        set
        {
            if (value == _now)
            {
                return;
            }

            _now = value;
            OnPropertyChanged();
        }
    }

    public event PropertyChangedEventHandler PropertyChanged;

    private void TimerTick(object sender, EventArgs e)
    {
        Now = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
    }

    private void OnPropertyChanged([CallerMemberName]string propertyName = null)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }
}
```