# SelectMany


### 範例一：類似 Join 的效果

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

### 範例二

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