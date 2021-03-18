# SelectMany

### 範例：Cross Join 效果

輸出 九九乖法表 的乘數與被乘數清單 !

```csharp
var ints =  Enumerable.Range(1, 9);

ints.SelectMany(i1 => ints, (i1, i2) => (i1, i2)).Dump();
```

### 範例：攤平

```csharp
var arr = new[] {
	new [] { "A", "B",},
	new [] { "C", "D", "E"},
	new [] { "F", "G"},
};

arr.SelectMany(a => a).Dump();
```

### 範例：類似 Join 的效果

```csharp
void Main()
{
	var dtoAs = new[] 
	{
		new DtoA
		{
			Id = 1,
			DtoBs = new []
			{
				new DtoB { Id = 1, Name = "A1B1", },
				new DtoB { Id = 2, Name = "A1B2", },
				new DtoB { Id = 3, Name = "A1B3", },
			}
		},
		new DtoA
		{
			Id = 2,
			DtoBs = new []
			{
				new DtoB { Id = 1, Name = "A2B1", },
				new DtoB { Id = 2, Name = "A2B2", },
				new DtoB { Id = 3, Name = "A2B3", },
			}
		},
	};

	dtoAs.SelectMany(dtoA => dtoA.DtoBs,
					 (dtoA, dtoB) => new {
					 	DtoAId = dtoA.Id,
						DtoBId = dtoB.Id,
						DtoBName = dtoB.Name
					 } ).Dump();
}

public class DtoA
{
	public int Id { get; set; }
	
	public DtoB[] DtoBs { get; set; }
}

public class DtoB
{
	public int Id { get; set; }
	
	public string Name { get; set; }
}
```

### 範例：攤平比較

```csharp

void Main()
{
	var dtoAs = new[] 
	{
		new DtoA
		{
			Id = 1,
			DtoBs = new []
			{
				new DtoB { Id = 1, Name = "A1B1", },
				new DtoB { Id = 2, Name = "A1B2", },
				new DtoB { Id = 3, Name = "A1B3", },
			}
		},
		new DtoA
		{
			Id = 2,
			DtoBs = new []
			{
				new DtoB { Id = 1, Name = "A2B1", },
				new DtoB { Id = 2, Name = "A2B2", },
				new DtoB { Id = 3, Name = "A2B3", },
			}
		},
	};

	dtoAs.SelectMany(dtoA => dtoA.DtoBs)
	     .Select(dtoB => dtoB.Name).Dump();

	dtoAs.SelectMany(dtoA => dtoA.DtoBs,
					 (dtoA, dtoB) => dtoB.Name ).Dump();
}

public class DtoA
{
	public int Id { get; set; }
	
	public DtoB[] DtoBs { get; set; }
}

public class DtoB
{
	public int Id { get; set; }
	
	public string Name { get; set; }
}

```