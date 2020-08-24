# Task

## Constructors

### [Task(Action<Object>, Object)](https://docs.microsoft.com/en-us/dotnet/api/system.threading.tasks.task.-ctor)

```csharp
var inputState = 1;

var task = new Task(i => {
	var a = (i as int?).GetValueOrDefault() + 1;
	a.Dump();
}, inputState);

task.RunSynchronously();

Task.WhenAll(task);
```
