# 取出指定實作 abstract of T class 的類別


```csharp
void Main()
{
    var dtoA = new DtoA();

    Assembly.GetExecutingAssembly()
            .GetTypes()
            .Where(t => {

                if (t.BaseType is Type baseType
                 && baseType.IsGenericType
                 && baseType.GetGenericTypeDefinition() == typeof(Validator<>)
                 && baseType.GenericTypeArguments.Contains(dtoA.GetType()))
                {
                    return true;
                }
                
                return false;
            }).Dump();
    
    // 要取出 type ValidatorDtoA
}

public abstract class Validator<T>
{
    public abstract string Name { get; }

    public T ViewModel { get; set; }
}

public class ValidatorDtoA : Validator<DtoA>
{
    public override string Name => "DtoA";
}

public class ValidatorDtoB : Validator<DtoB>
{
    public override string Name => "DtoB";
}

public class DtoA { }

public class DtoB { }
```
