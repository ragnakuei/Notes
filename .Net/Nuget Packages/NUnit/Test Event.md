# Test Event

## 範例一

```csharp
public class RedoUndoService<T>
{
    public RedoUndoService(int maxStep)
    {
        _maxStep = maxStep;
    }

    public Stack<T> DoList { get; set; } = new Stack<T>();

    public Stack<T> UndoList { get; set; } = new Stack<T>();

    public event EventHandler<T> UndoEvent;

    public void Do(T t)
    {
        DoList.Push(t);
        AdjustDoListOverMaxSteps();
        UndoList.Clear();
    }

    public void Undo()
    {
        var undoAction = DoList.Pop();
        UndoEvent?.Invoke(this, undoAction);
        UndoList.Push(undoAction);
    }

    private readonly int _maxStep;

    private void AdjustDoListOverMaxSteps()
    {
        if (DoList.Count > _maxStep)
        {
            DoList = new Stack<T>(DoList.Take(_maxStep).Reverse());
        }
    }
}

```

```csharp
[Test]
public void UndoRaiseEvent()
{
    var target = new RedoUndoService<string>(3);
    target.Do("A");
    target.Do("B");

    string actual = string.Empty ;
    EventHandler<string> handler = (sender, e) =>
                                    {
                                        actual = e;
                                    };

    target.UndoEvent += handler;
    target.Undo();
    target.UndoEvent -= handler;

    var expected = "B";
    Assert.AreEqual(expected, actual);
}
```