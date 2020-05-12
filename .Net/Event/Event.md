# Event

- [Event](#event)
  - [宣告讓外部指定的 Event](#%e5%ae%a3%e5%91%8a%e8%ae%93%e5%a4%96%e9%83%a8%e6%8c%87%e5%ae%9a%e7%9a%84-event)
  - [自訂的 EventArgs](#%e8%87%aa%e8%a8%82%e7%9a%84-eventargs)
  - [注意事項](#%e6%b3%a8%e6%84%8f%e4%ba%8b%e9%a0%85)
    - [WPF e.Handled = true](#wpf-ehandled--true)

---

當內部運作至指定時機時，提供一個外部 Callback 的執行動作

---

## 宣告讓外部指定的 Event

```csharp
public event EventHandler<ValueChangeEventArgs<string>> ValueChangeWhenClose;

protected virtual void OnValueChangeWhenClose(ValueChangeEventArgs<string> e)
{
    ValueChangeWhenClose?.Invoke(this, e);
}
```

## 自訂的 EventArgs

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

## 注意事項

### WPF e.Handled = true 

如果在某個事件內 加上 `e.Handled = true` 時，就會讓 event chaining 後面的事件都不會處理 !!