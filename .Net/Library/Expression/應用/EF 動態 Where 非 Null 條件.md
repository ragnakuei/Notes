# EF 動態 Where 非 Null 條件

```csharp
void Main()
{
    var customer = new Customer { InCome = 810000, CriminalRecord = false };
    
    var service = new CustomerRiskStateService();
    service.Assign(customer);
    
    customer.Dump();
}

public class CustomerRiskStateService
{
    public void Assign(Customer customer)
    {
        customer.RiskState = GenerateRiskState(customer);
    }
    
    private RiskState GenerateRiskState(Customer customer)
    {
        if (customer.InCome > 800000)
        {
            if (customer.CriminalRecord)
            {
                return RiskState.High;
            }
            else
            {
                return RiskState.Low;
            }
        }

        if (customer.YearsInJob >= 2)
        {
            return RiskState.Low;
        }

        if (customer.UsesCreditCard)
        {
            return RiskState.Low;
        }
        else
        {
            return RiskState.High;
        }
    }
}


public class Customer
{
    public int InCome { get; set; }
    
    public int YearsInJob { get; set; }
    
    public bool CriminalRecord { get; set; }
    
    public bool UsesCreditCard { get; set; }
    
    public RiskState RiskState { get; set; }
}

public enum RiskState
{
    High = 1,
    Low = 2
}
```