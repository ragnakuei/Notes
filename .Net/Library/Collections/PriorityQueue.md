# [PriorityQueue](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.priorityqueue-2)

## 範例

- 低 priority 會優先取出
- 同 priority 的順序則不一定照原順序

```cs
var queue = new PriorityQueue<int, int>();

queue.Enqueue(1,2);
queue.Enqueue(2,2);
queue.Enqueue(3,2);
queue.Enqueue(4,1);

queue.Dequeue().Dump();   // 4
queue.Dequeue().Dump();   // 1
queue.Dequeue().Dump();   // 3
queue.Dequeue().Dump();   // 2
```
