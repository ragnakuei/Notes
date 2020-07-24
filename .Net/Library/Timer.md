# Timer

## 較精準的每秒計時器

可以固在 1 秒過後的某誤差時間內來執行 callback

而不是每次間隔 1 秒來執行

```csharp
static Timer timer;

void Main()
{
	// 1000 - DateTime.UtcNow.Millisecond = number of milliseconds until the next second
	timer = new Timer(TimerCallback, null, GerIntervalPerios(), 0);
}

void TimerCallback(object state)
{
	// Important to do this before you do anything else in the callback
	timer.Change(GerIntervalPerios(), 0);

	Debug.WriteLine(DateTime.UtcNow.ToString("ss.ffff"));
}

private int GerIntervalPerios()
{
	return 1000 - DateTime.UtcNow.Millisecond;
}
```

## 每間隔 5000 ticks 觸發一次

```csharp
private DateTime previous = DateTime.Now;

// 10000ticks = 1ms
private int IntervalInTicks = 5000;

void Main()
{
	while (true)
	{
		var now = DateTime.Now;

		var runInterval = (now- previous).Ticks;
		if(runInterval > IntervalInTicks)
		{
			// DO
			runInterval.Dump();
			DateTime.Now.ToString("ss:fffffff").Dump();

			previous = now;
		}
	}
}
```

## 以起始時間來計算，每 5000 ticks 觸發一次

```csharp
private DateTime previous = DateTime.Now;

// 10000ticks = 1ms
private int IntervalInTicks = 5000;

void Main()
{
	while (true)
	{
		var now = DateTime.Now;

		var runInterval = (now- previous).Ticks;
		if(runInterval > IntervalInTicks)
		{
			// DO
			runInterval.Dump();
			DateTime.Now.ToString("ss:fffffff").Dump();

			previous = previous.AddTicks(IntervalInTicks);
		}
	}
}
```
