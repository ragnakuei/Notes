# Test Event

## 範例一

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