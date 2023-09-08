# 執行 Benchmark


```cs
void Main()
{
	#region 測試區

	Test01().Dump();
	Test02().Dump();

	#endregion
}

Random random = new();

#region 反白下面二行，再按下 ctrl + shit + B 執行 Benchmark

int Test01() => Test01((char)random.Next(99, 120));
int Test02() => Test02((char)random.Next(99, 120));

#endregion

#region 實作內容

int Test01(char c) {
	if(int.TryParse(c.ToString(), out var result))
	{
		return result;
	}
	
	return -1;
}

int Test02(char c) {
	return (int)char.GetNumericValue(c);
}

#endregion
```