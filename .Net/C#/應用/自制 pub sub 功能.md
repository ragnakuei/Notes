# 自制 pub sub 功能

```csharp
public static class EventHandlerService
{
	private static readonly Dictionary<EventKeys, IList<Action<IEventArgs>>> _eventStore = new Dictionary<EventKeys, IList<Action<IEventArgs>>>();

	public static void Subscribe(EventKeys key,Action<IEventArgs> eventHandler)
	{
		if (_eventStore.ContainsKey(key) == false)
		{
			var targetEvents = new List<Action<IEventArgs>> { eventHandler };
			_eventStore.Add(key, targetEvents);
		}
		else
		{
			var targetEvents = _eventStore.GetValue(key);
			targetEvents.Add(eventHandler);
		}
	}

	public static void Unsubscribe(EventKeys key, Action<IEventArgs> eventHandler)
	{

		if (_eventStore.ContainsKey(key) == false)
		{
			return;
		}
		else
		{
			var targetEvents = _eventStore.GetValue(key);
			targetEvents.Remove(eventHandler);

			if (targetEvents.Count == 0)
			{
				_eventStore.Remove(key);
			}
		}
	}

	public static void Publish(EventKeys key, object sender, IEventArgs eventArgs)
	{
		var targetEvent = _eventStore.GetValue(key);
		targetEvent.ForEach(e => e?.Invoke(eventArgs));
	}
}

public interface IEventArgs
{

}

public enum EventKeys
{
	UpdatePropertyPanelEvent,
}

void Main()
{
	var a1 = new TestA();
	var a2 = new TestA();

	IEventArgs eventArgs = new EventArgsA { Id = 1 };

	EventHandlerService.Publish(EventKeys.UpdatePropertyPanelEvent, this, eventArgs);
}

public class TestA
{
	public TestA()
	{
		EventHandlerService.Subscribe(EventKeys.UpdatePropertyPanelEvent, UpdatePropertyPanelEventExecute);
	}

	void UpdatePropertyPanelEventExecute(IEventArgs e)
	{
		MethodInfo.GetCurrentMethod().Name.Dump();
		e.Dump();
	}

	~TestA()
	{
		EventHandlerService.Unsubscribe(EventKeys.UpdatePropertyPanelEvent, UpdatePropertyPanelEventExecute);
	}
}

public class EventArgsA : IEventArgs
{
	public int Id { get; set; }
}
```
