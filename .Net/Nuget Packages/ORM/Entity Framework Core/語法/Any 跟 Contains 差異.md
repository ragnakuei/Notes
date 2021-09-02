# Any 跟 Contains 差異

## 差異一：Contains 支援非 Entity Source，而 Any 必須套用 Entity Source

### Contains 支援非 Entity Source

```csharp
var customerIds = new[] {
	"FOLKO"	,
	"MEREP"	,
};

// exception
//Orders.Where(o => customerIds.Any(i => i == o.CustomerID)).Dump();

// ok
Orders.Where(o => customerIds.Contains(o.CustomerID)).Dump();
```

### Any 必須套用 Entity Source

```csharp
// ok
Orders.Where(o => o.OrderDetails.Any(od => od.UnitPrice > 10 )).Dump();
```
