# [IDocumentContent](https://docs.devexpress.com/CoreLibraries/DevExpress.Mvvm.IDocumentContent)

- [IDocumentContent](#idocumentcontent)
  - [OnClose(CancelEventArgs)](#onclosecanceleventargs)
  - [OnDestroy()](#ondestroy)

---

- 可直接放在 UserControl 上，來做為是否可關閉的判斷

---

## OnClose(CancelEventArgs)

在 View 上 Binding CanBeClosed ，讓 UI 決定是否可關閉此 Control

```csharp
private bool _canBeClosed;

public bool CanBeClosed
{
    get => _canBeClosed;
    set => SetProperty(ref _canBeClosed, value, nameof(CanBeClosed));
}

#region IDocumentContent

public virtual IDocumentOwner DocumentOwner { get; set; }

public virtual void OnClose(CancelEventArgs e)
{
    e.Cancel = !CanBeClosed;
}

public virtual void OnDestroy()
{
}

public virtual object Title
{
    get
    {
        return "Title";
    }
}

#endregion
```

---

## OnDestroy()
