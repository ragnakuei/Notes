# BindingList

因為實作了 `IRaiseItemChangedEvents` 所以在元素數量異動時，就會同步通知 form 的 control 進行更新

但是元素內的 property 變更時，是不會同步通知 form 的 control 進行更新

---

## 需求一

需求：符合以下二個條件都要同步通知 form 的 control 進行更新

1. 元素數量異動時
1. 元素內的 property 變更時

### 做法一：不用 BindingList\<T>

```csharp
private List<TestListBoxItem> _listBoxItems;

_listBoxItems = new List<TestListBoxItem>
            {
                new TestListBoxItem { Id = 1, Name = "Name1", Value="Value1"},
                new TestListBoxItem { Id = 2, Name = "Name2", Value="Value2"},
                new TestListBoxItem { Id = 3, Name = "Name3", Value="Value3"},
            };
```

```csharp
var itemCount = _listBoxItems.Count + 1;
_listBoxItems.Add(new TestListBoxItem { Id = itemCount, Name = $"Name{itemCount}", Value = $"Value{itemCount}" });

var target = _listBoxItems.First();
target.Value += "1";

listBox.DataSource = null;
listBox.DisplayMember = nameof(TestListBoxItem.Value);
listBox.DataSource = _listBoxItems;
```

注意：

下面三行的第二、三行的執行順序有差

這個會先清空資料，再指定 DisplayMember，按快一點不會有閃爍的情況

```csharp
listBox.DataSource = null;
listBox.DisplayMember = nameof(TestListBoxItem.Value);
listBox.DataSource = _listBoxItems;
```

下面的執行順序，按快一點會有閃爍的情況

> 因為會先把 item 的 type name 放到 control 上，然後再變更顯示的資料，所以會有閃爍的情況 !

```csharp
listBox.DataSource = null;
listBox.DataSource = _listBoxItems;
listBox.DisplayMember = nameof(TestListBoxItem.Value);
```

### 做法二：用 BindingList\<T>

`BindingList.ResetBindings()` 本身就可以做重新 Binding 的動作，讓 Control 可以重新抓取正確的資料 !

```csharp
private BindingList<TestListBoxItem> _listBoxItems;

_listBoxItems = new BindingList<TestListBoxItem>
            {
                new TestListBoxItem { Id = 1, Name = "Name1", Value="Value1"},
                new TestListBoxItem { Id = 2, Name = "Name2", Value="Value2"},
                new TestListBoxItem { Id = 3, Name = "Name3", Value="Value3"},
            };
```

```csharp
_listBoxItems.RaiseListChangedEvents = false;

var itemCount = _listBoxItems.Count + 1;
_listBoxItems.Add(new TestListBoxItem { Id = itemCount, Name = $"Name{itemCount}", Value = $"Value{itemCount}" });

var target = listBox.Items[0] as TestListBoxItem;
target.Value += "1";

_listBoxItems.RaiseListChangedEvents = true;
_listBoxItems.ResetBindings();
```
