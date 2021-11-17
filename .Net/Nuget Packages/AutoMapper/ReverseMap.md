# [ReverseMap](https://docs.automapper.org/en/stable/Reverse-Mapping-and-Unflattening.html)

```cs
void Main()
{
    var configuration = new MapperConfiguration(cfg =>
    {
        cfg.CreateMap<Order, OrderDto>()
              // flatten
              // 從第二個 MapFrom 取出數值後，放到第一個參數的對應
              .ForMember(dto => dto.CustomerName, opt => opt.MapFrom(o => o.Customer.Name))
              
              // anti-flatten
              // 從第二個 MapFrom 取出數值後，放到第一個參數的對應
              .ReverseMap()
              .ForPath(o => o.Customer.Name, opt => opt.MapFrom(dto => dto.CustomerName));
    });

    var mapper = configuration.CreateMapper();

    var order = new Order
    {
        Customer = new Customer
        {
            Name = "Bob"
        },
        Total = 15.8m
    };

    // flatten
    var orderDto = mapper.Map<Order, OrderDto>(order);

    orderDto.Dump();

    // 重新給定資料
    orderDto.CustomerName = "Joe";
    orderDto.Total = 10.1m;

    // anti-flatten
    //mapper.Map<OrderDto, Order>(orderDto, order);
    var order2 = mapper.Map<OrderDto, Order>(orderDto);
    
    order.Dump();
}

public class OrderDto
{
    public decimal Total { get; set; }

    public string CustomerName { get; set; }
}

public class Customer
{
    public string Name { get; set; }
}

public class Order
{
    public Customer Customer { get; set; }

    public decimal Total { get; set; }
}
```