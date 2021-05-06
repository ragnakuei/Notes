# 取出實作 abstract of T class 的所有類別

```csharp
void Main()
{
    // 取出 ValidatorDtoA instance 並且給定 dtoA instance

    Assembly.GetExecutingAssembly()
            .GetTypes()
            .Where(t => {

                if (t.BaseType is Type baseType
                 && baseType.IsGenericType
                 && baseType.GetGenericTypeDefinition() == typeof(Validator<>))
                {
                    return true;
                }
                
                return false;
            })
            .Select(t => new {
                t,
                t.BaseType,
            })
            .Dump();
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

// 用來確認不會取到實作這個抽象類別的 instance
public abstract class FakeValidator<T>
{
    public abstract string Name { get; }

    public T ViewModel { get; set; }
}

public class FakeValidatorDtoA : FakeValidator<DtoA>
{
    public override string Name => "DtoA";
}

public class FakeValidatorDtoB : FakeValidator<DtoB>
{
    public override string Name => "DtoB";
}

public class DtoA { }

public class DtoB { }
```