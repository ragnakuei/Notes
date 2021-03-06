# Indexer 索引子

- [Indexer 索引子](#indexer-%e7%b4%a2%e5%bc%95%e5%ad%90)
	- [仿 Array\<T>](#%e4%bb%bf-arrayt)
	- [自訂義集合型別](#%e8%87%aa%e8%a8%82%e7%be%a9%e9%9b%86%e5%90%88%e5%9e%8b%e5%88%a5)

---

## 仿 Array\<T>

```csharp
void Main()
{
	var ints = new Array<int>(5)
	{
		[0] = 1,
		[1] = 2,
		[2] = 3,
	};
	ints.Dump();

	ints = new Array<int>(5)
	{
		2,
		3,
		4,
	};

	ints.Dump();
}

public class Array<T> : IEnumerable<T>
{
	private readonly T[] _array;	
	
	public Array(int size)
	{
		_array = new T[size];
	}

	private int _indexForAdd = 0;

	/// <summary>
	/// 初始化時，只給定 value
	/// </summary>
	public void Add(T element)
	{
		_array[_indexForAdd] = element;
		_indexForAdd++;
	}

	/// <summary>
	/// 初始化時，給定 index = value
	/// </summary>
	public T this[int i]
	{
		get => _array[i];
		set => _array[i] = value;
	}

	public IEnumerator<T> GetEnumerator()
	{
		return ((IEnumerable<T>)_array).GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return _array.GetEnumerator();
	}
}
```

## 自訂義集合型別

```csharp
void Main()
{
	var people = new People
	{
		[1] = new Person { Name = "A" },
		["B"] = new Person { Id = 2 },
	};

	people.Value.Dump();
}

public class People
{
	private readonly Dictionary<int, Person> _idBasePeople = new Dictionary<int, Person>();
	private readonly Dictionary<string, Person> _nameBasePeople = new Dictionary<string, Person>();

	public Person this[int id]
	{
		set
		{
			value.Id = id;
			if (_idBasePeople.ContainsKey(id))
			{
				_idBasePeople[id] = value;
			}
			else
			{
				_idBasePeople.Add(id, value);
				_nameBasePeople.Add(value.Name, value);
			}
		}
		get
		{
			Person result = default(Person);
			_idBasePeople.TryGetValue(id, out result);
			return result;
		}
	}

	public Person this[string name]
	{
		set
		{
			value.Name = name;
			if (_nameBasePeople.ContainsKey(name))
			{
				_nameBasePeople[name] = value;
			}
			else
			{
				_nameBasePeople.Add(name, value);
				_idBasePeople.Add(value.Id, value);
			}
		}
		get
		{
			Person result = default(Person);
			_nameBasePeople.TryGetValue(name, out result);
			return result;
		}
	}

	public Person[] Value
	{
		get
		{
			return _idBasePeople.Values.ToArray();
		}
	}
}


public class Person
{
	public int Id { get; set; }
	public string Name { get; set; }
}
```