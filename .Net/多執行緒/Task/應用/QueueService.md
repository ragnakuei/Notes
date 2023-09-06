# QueueService

[進階版：可以做分流](https://github.com/ragnakuei/KueiPackages/blob/master/KueiPackages/Services/QueueService.cs)


## 簡易版

```cs
private int _count = 0;

private Random _random = new Random();

async Task Main()
{
	var runCount = 100;

	// 構想：以非同步 + Delay 模擬各 Request 作業狀況
	// 預期要的結果：經過 100 個 requests 各種狀況的處理後， _count 的值要為 100

	// 語法情境1：沒套用 QueueService 的情況，count 總數與預期不符 !
	//var tasks = Enumerable.Range(0, runCount)
	//					  .Select(i => Task.Factory.StartNew(() => AddCount()))
	//					  .ToArray();

	// 語法情境2：套用 QueueService 的情況，count 總數與預期相符 !
	var queueService = new QueueService();
	var tasks = Enumerable.Range(0, runCount)
			  .Select(i =>
			  
				  queueService.QueueActionAsync(new ActionDto
				  {
					  Id = Guid.NewGuid(),
					  Action = () => AddCount(),
				  })

			  ).ToArray();

	await Task.WhenAll(tasks);
	Console.WriteLine(_count);
}


private void AddCount()
{
	var currentCount = _count;

	// 針對每個 task 給予不同的 delay，來儘量模擬同時存取的作業 !
	Thread.Sleep(_random.Next(5, 10));

	_count++;

	//Console.WriteLine(_count);
}



public class ActionDto
{
	/// <summary>
	/// 辨識 Queue 所對應的作業
	/// </summary>
	public Guid Id { get; set; }

	public Action Action { get; set; }
}

public class QueueService
{
	/// <summary>
	/// 正在處理清單
	/// <remarks>分流後的物件，會放在這個清單中，清單中的物件等於是正在處理的</remarks>
	/// </summary>
	private readonly ConcurrentQueue<ActionDto> queue = new ConcurrentQueue<ActionDto>();

	/// <summary>
	/// 每次 retry 間隔
	/// </summary>
	private int _delayMilliseconds = 10;

	public async Task QueueActionAsync(ActionDto dto,
									   int retryCount = 30)
	{
		try
		{
			await WaitIfSatisfiedGroupCondition(dto, retryCount);

			dto.Action.Invoke();
		}
		finally
		{
			Remove(dto);
		}
	}

	/// <summary>
	/// 進行 分流 & Queue 的處理
	/// </summary>
	private async Task WaitIfSatisfiedGroupCondition(ActionDto dto,
													 int retryMaxCount)
	{
		queue.Enqueue(dto);

		var retryCount = 0;

		while (retryCount++ < retryMaxCount)
		{
			queue.TryPeek(out var peek);
			if (dto == peek)
			{
				return;
			}

			await Task.Delay(_delayMilliseconds);
		}

		throw new Exception($"到達寫入重試上限{retryMaxCount}次，請聯絡系統開發人員 !");
	}

	/// <summary>
	/// 將 Dto 從正在處理清單中移除
	/// </summary>
	private void Remove(ActionDto dto)
	{
		if (queue.TryDequeue(out _) == false)
		{
			throw new Exception($"Queue 移除 dto 失敗 !");
		}
		else
		{
			//Console.WriteLine($"Queue 移除 dto 成功 !");
		}
	}
}
```