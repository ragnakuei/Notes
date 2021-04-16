# 關閉其他正在運行的相同 Form

- 只要給定參數 /close
- 就會關閉除了目前正在運行的 Process 以外的同名 Process Name


```csharp
/// <summary>
///  The main entry point for the application.
/// </summary>
[STAThread]
static void Main()
{
    // 主要的判斷語法在這個 if 內
    if (Environment.GetCommandLineArgs().Contains("/close"))
    {
        Process currentProcess = Process.GetCurrentProcess();
        Process.GetProcessesByName(process.ProcessName)
                .ForEach(p =>
                {
                    if (p != currentProcess)
                    {
                        p.CloseMainWindow();
                    }
                });
        return;
    }

    Application.SetHighDpiMode(HighDpiMode.SystemAware);
    Application.EnableVisualStyles();
    Application.SetCompatibleTextRenderingDefault(false);
    Application.Run(new Form1());
}
```