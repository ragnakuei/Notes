# Range

```cs
using System.Reactive.Subjects;
using System.Reactive.Linq;
using System.Reactive;

void Main()
{
	var observer = Observer.Create<int>(s => SubscribeAction(s),
								       () => "Complete".Dump());
	observer.OnNext(1);
	observer.OnCompleted();

    // observer 可再次被重用
	Observable.Range(1, 10)
			  .Subscribe(observer);

}

private void SubscribeAction(int i)
{
	i.Dump("SubscribeAction");
}
```

可用 using 包起來，給定所有 observer 執行完畢後的動作

```cs
using System.Reactive.Subjects;
using System.Reactive.Linq;
using System.Reactive;

void Main()
{
	var observer = Observer.Create<int>(s => SubscribeAction(s),
								       () => "Complete".Dump());
	observer.OnNext(1);
	observer.OnCompleted();

	// observer 可再次被重用
	using (Observable.Range(1, 10)
			         .Subscribe(observer))
	{
		"All Completed".Dump();
	}

}

private void SubscribeAction(int i)
{
	i.Dump("SubscribeAction");
}
```