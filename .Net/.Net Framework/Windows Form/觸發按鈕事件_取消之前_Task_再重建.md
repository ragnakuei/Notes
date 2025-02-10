# 觸發按鈕事件*取消之前\_Task*再重建

```cs
public partial class Form1 : Form
{
    private (Task task, CancellationTokenSource cts) _taskCts;

    public Form1()
    {
        InitializeComponent();
        _taskCts = (Task.CompletedTask, new CancellationTokenSource());
    }

    private void Form1_Load(object sender, EventArgs e)
    {
    }

    private async void button1_MouseDown(object sender, MouseEventArgs e)
    {
        if (_taskCts.task != null)
        {
            lblTaskStatus.BeginInvoke(new Action(() => { lblTaskStatus.Text = _taskCts.task.Status.ToString(); }));

            _taskCts.cts.Cancel();

            try
            {
                await _taskCts.task;
            }
            catch (OperationCanceledException)
            {
                Console.WriteLine("Button1_Click Task Cancelled : OperationCanceledException");
            }

            _taskCts.cts.Dispose();
            // _taskCts = (Task.CompletedTask, new CancellationTokenSource());

            lblMessage.BeginInvoke(new Action(() => { lblMessage.Text = "previous Button1_Click Cancelled"; }));
        }

        _taskCts.cts  = new CancellationTokenSource();
        _taskCts.task = PlayVoiceAsync();

        lblMessage.BeginInvoke(new Action(() => { lblMessage.Text       = "Button1_Click Task Started"; }));
        lblTaskStatus.BeginInvoke(new Action(() => { lblTaskStatus.Text = _taskCts.task.Status.ToString(); }));

        Console.WriteLine($"Button1_MouseDown OK : {DateTime.Now:HH:mm:ss fffffff}");
    }

    private Task PlayVoiceAsync()
    {
        return Task.Run(async () =>
                        {
                            try
                            {
                                // 如果要包裝的動作有支援 CancellationToken，就可以直接使用
                                // await Task.Delay(3000, _taskCts.cts.Token);

                                // 如果要包裝的動作不支援 CancellationToken，就要自己寫迴圈搭配 ThrowIfCancellationRequested

                                var startTime = DateTime.Now;

                                // 模擬迴圈檢查 - 3 秒
                                while ((DateTime.Now - startTime).TotalSeconds < 3)
                                {
                                    _taskCts.cts.Token.ThrowIfCancellationRequested();
                                    await Task.Delay(10);
                                }
                            }
                            catch (OperationCanceledException)
                            {
                                lblMessage.BeginInvoke(new Action(() => { lblMessage.Text = "Button1_Click inner Task Cancelled"; }));
                                return;
                            }
                            catch (Exception ex)
                            {
                                lblMessage.Invoke(new Action(() => { lblMessage.Text = $"Button1_Click inner Task Error: {ex.Message}"; }));
                                return;
                            }

                            lblMessage.BeginInvoke(new Action(() => { lblMessage.Text = "Button1_Click inner Task OK"; }));
                        },
                        _taskCts.cts.Token);
    }

    private void button2_MouseDown(object sender, MouseEventArgs e)
    {
        Console.WriteLine($"Button2_MouseDown OK : {DateTime.Now:HH:mm:ss fffffff}");
    }
}
```
