# Event

當內部運作至指定時機時，提供一個外部 Callback 的執行動作

---

宣告讓外部指定的 Event

```csharp
public event EventHandler<ValueChangeEventArgs<string>> ValueChangeWhenClose;

protected virtual void OnValueChangeWhenClose(ValueChangeEventArgs<string> e)
{
    ValueChangeWhenClose?.Invoke(this, e);
}
```

自訂的 EventArgs

```csharp
public class ValueChangeEventArgs<T>
{
    public T OldValue { get; set; }
    public T NewValue { get; set; }
}
```

內部在指定的地方加上呼叫 Event 的語法

```csharp
var args = new ValueChangeEventArgs<string>
            {
                OldValue = _initialLabelValue,
                NewValue = LabelValue,
            };
OnValueChangeWhenClose(args);
```
