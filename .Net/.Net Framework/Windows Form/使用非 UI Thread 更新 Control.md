# 使用非 UI Thread 更新 Control

```cs
lbl.Invoke(new Action(() => { lbl.Text = "OK"; }));
lbl.BeginInvoke(new Action(() => { lbl.Text = "OK"; }));
```

其中 Invoke 會等待 UI Thread 執行完畢，BeginInvoke 則是非同步執行。
