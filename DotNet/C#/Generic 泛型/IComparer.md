# [IComparer](https://docs.microsoft.com/zh-tw/dotnet/api/system.collections.generic.icomparer-1)

## 原理

a 跟 b 比較時，依照回傳值來決定排序規則
| 值  | 結果     |
| --- | -------- |
| -1  | a 在前面 |
| 0   | 不排序   |
| 1   | b 在前面 |

## Sample : OrderBy + 字串轉成 Long 進行排序

字串轉成數字，再進行排序，如果轉換失敗的排後面

PS: string.Empty 跟 null 未判斷 !

```csharp
void Main()
{
	var strs = new List<string>
	{
		"2",
		null,
		"1",
		""
	};
	
	strs.OrderBy(s => s, new StringToLongComparer()).Dump();
}

public class StringToLongComparer : IComparer<string>
{
	public int Compare(string s1, string s2)
	{
		var b1 = long.TryParse(s1, out long l1);
		var b2 = long.TryParse(s2, out long l2);

		if (b1 && b2 == false)
		{
			return -1;
		}

		if (b1 == false && b2)
		{
			return 1;
		}

		return l1.CompareTo(l2);
	}
}
```

