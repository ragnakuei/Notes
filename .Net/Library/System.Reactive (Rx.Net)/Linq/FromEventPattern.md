# FromEventPattern

用來綁定事件

```cs
public partial class Form1 : Form
{
    public Form1()
    {
        InitializeComponent();

        var windowMove = Observable.FromEventPattern(this, "Move")
            .Subscribe(evt =>
            {
                if(evt.Sender is not Form form)
                {
                    return;
                }

                var position = form.PointToScreen(new Point(0, 0));

                Debug.WriteLine($"Position X: {position.X} Y:{position.Y}");
            });
    }
}
```