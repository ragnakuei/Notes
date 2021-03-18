# 暫時\_恢復 Layout 更新

進行設定前，停止 Layout 更新

```csharp
Control.SuspendLayout()
Form.SuspendLayout();
```

設定完畢後，恢復 Layout 更新

```csharp
Control.ResumeLayout(false);
Control.PerformLayout();

Form.ResumeLayout(false);
```
