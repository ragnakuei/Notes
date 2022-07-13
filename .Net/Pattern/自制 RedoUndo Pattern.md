# 自制 RedoUndo Pattern

替代的 Design Pattern
- Memento Pattern
  - [Implementing Undo/Redo With The Memento Pattern](https://medium.com/design-patterns-in-python/memento-pattern-eba610b3b59c)

## Sample

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
