# [AutoMapper](https://docs.automapper.org/en/stable/index.html)

## 自動對應規則

- 相同的 Property Name
- 當 From 有 Get + PropertyName 的以下項目也會對應至 Destination 的 Property
  - Property
    - GetName 會對應至 Name
  - Method
    - GetName() 會對應至 Name
- 巢狀的 Property Name
  - 例：OrderItem.Name => OrderItemName
