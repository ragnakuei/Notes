# [Property Filter Func Service](https://github.com/ragnakuei/PropertyFilterFuncLibrary)



```csharp
public class PropertyFilterService<T>
{
    public Func<T, bool> BuildFilterExpression(FilterDto<T> filterDto)
    {
        var pe = Expression.Parameter(typeof(T), nameof(T).ToLower());

        var result = _operationExpressionMap.GetValue(filterDto.Operation).Invoke(filterDto, pe);

        if (result == null)
        {
            throw new NotImplementedException();
        }

        return Expression.Lambda<Func<T, bool>>(result, pe).Compile();
    }

    private Dictionary<Operation, Func<FilterDto<T>, ParameterExpression, Expression>> _operationExpressionMap
        = new Dictionary<Operation, Func<FilterDto<T>, ParameterExpression, Expression>>
            {
                [Operation.GreaterThan]        = (dto, pe) => GenerateGreaterThan(dto, pe),
                [Operation.GreaterThanOrEqual] = (dto, pe) => GenerateGreaterThanOrEqual(dto, pe),
                [Operation.LessThan]           = (dto, pe) => GenerateLessThan(dto, pe),
                [Operation.LessThanOrEqual]    = (dto, pe) => GenerateLessThanOrEqual(dto, pe),
                [Operation.Equal]              = (dto, pe) => GenerateEqual(dto, pe),
                [Operation.Between] = (dto, pe) =>
                                    {
                                        OrderValue1Value2(dto);
                                        return GenerateBetween(dto, pe);
                                    },
            };

    private static void OrderValue1Value2(FilterDto<T> filterDto)
    {
        if (filterDto.Value1 is int)
        {
            OrderValue1Value2ByInt(filterDto);
        }
    }

    private static void OrderValue1Value2ByInt(FilterDto<T> filterDto)
    {
        var v1 = Convert.ToInt32(filterDto.Value1);
        var v2 = Convert.ToInt32(filterDto.Value2);

        if (v1 > v2)
        {
            filterDto.Value1 = v2;
            filterDto.Value2 = v1;
        }
    }

    private static Expression GenerateGreaterThan(FilterDto<T> filterDto, ParameterExpression pe)
    {
        return Expression.GreaterThan(
                                        Expression.Property(pe, filterDto.PropertyName),
                                        Expression.Constant(filterDto.Value1)
                                        );
    }

    private static Expression GenerateGreaterThanOrEqual(FilterDto<T> filterDto, ParameterExpression pe)
    {
        return Expression.GreaterThanOrEqual(
                                                Expression.Property(pe, filterDto.PropertyName),
                                                Expression.Constant(filterDto.Value1)
                                            );
    }

    private static Expression GenerateLessThan(FilterDto<T> filterDto, ParameterExpression pe)
    {
        return Expression.LessThan(
                                    Expression.Property(pe, filterDto.PropertyName),
                                    Expression.Constant(filterDto.Value1)
                                    );
    }

    private static Expression GenerateLessThanOrEqual(FilterDto<T> filterDto, ParameterExpression pe)
    {
        return Expression.LessThanOrEqual(
                                            Expression.Property(pe, filterDto.PropertyName),
                                            Expression.Constant(filterDto.Value1)
                                            );
    }

    private static Expression GenerateEqual(FilterDto<T> filterDto, ParameterExpression pe)
    {
        return Expression.Equal(
                                Expression.Property(pe, filterDto.PropertyName),
                                Expression.Constant(filterDto.Value1)
                                );
    }


    private static Expression GenerateBetween(FilterDto<T> filterDto, ParameterExpression pe)
    {
        var greaterThanExpr = Expression.GreaterThanOrEqual(
                                                            Expression.Property(pe, filterDto.PropertyName),
                                                            Expression.Constant(filterDto.Value1)
                                                            );

        var lessThanExpr = Expression.LessThanOrEqual(
                                                        Expression.Property(pe, filterDto.PropertyName),
                                                        Expression.Constant(filterDto.Value2)
                                                        );

        return Expression.AndAlso(greaterThanExpr, lessThanExpr);
    }
}
```

## Test Cases

```csharp
public class PropertyFilterServiceTests
{
    private List<Dto> _sourceData;

    [OneTimeSetUp]
    public void OneTimeSetUp()
    {
        _sourceData = new List<Dto>
                        {
                            new Dto { Id = 1 },
                            new Dto { Id = 2 },
                            new Dto { Id = 3 },
                            new Dto { Id = 4 },
                            new Dto { Id = 5 },
                        };
    }

    [Test]
    public void TestGreaterThan()
    {
        var target = new PropertyFilterService<Dto>();

        var filterDto = new FilterDto<Dto>
                        {
                            PropertyName = nameof(Dto.Id),
                            Operation    = Operation.GreaterThan,
                            Value1        = 4,
                        };

        var actualExpression = target.BuildFilterExpression(filterDto);

        var actual = _sourceData.Where(actualExpression);

        var expected = new List<Dto>
                        {
                            new Dto { Id = 5 },
                        };

        actual.Should().BeEquivalentTo(expected);
    }

    [Test]
    public void TestGreaterThanOrEqual()
    {
        var target = new PropertyFilterService<Dto>();

        var filterDto = new FilterDto<Dto>
                        {
                            PropertyName = nameof(Dto.Id),
                            Operation    = Operation.GreaterThanOrEqual,
                            Value1        = 5,
                        };

        var actualExpression = target.BuildFilterExpression(filterDto);

        var actual = _sourceData.Where(actualExpression);

        var expected = new List<Dto>
                        {
                            new Dto { Id = 5 },
                        };

        actual.Should().BeEquivalentTo(expected);
    }

    [Test]
    public void TestLessThan()
    {
        var target = new PropertyFilterService<Dto>();

        var filterDto = new FilterDto<Dto>
                        {
                            PropertyName = nameof(Dto.Id),
                            Operation    = Operation.LessThan,
                            Value1        = 2,
                        };

        var actualExpression = target.BuildFilterExpression(filterDto);

        var actual = _sourceData.Where(actualExpression);

        var expected = new List<Dto>
                        {
                            new Dto { Id = 1 },
                        };

        actual.Should().BeEquivalentTo(expected);
    }

    [Test]
    public void TestLessThanOrEqual()
    {
        var target = new PropertyFilterService<Dto>();

        var filterDto = new FilterDto<Dto>
                        {
                            PropertyName = nameof(Dto.Id),
                            Operation    = Operation.LessThanOrEqual,
                            Value1        = 1,
                        };

        var actualExpression = target.BuildFilterExpression(filterDto);

        var actual = _sourceData.Where(actualExpression);

        var expected = new List<Dto>
                        {
                            new Dto { Id = 1 },
                        };

        actual.Should().BeEquivalentTo(expected);
    }

    [Test]
    public void TestEqual()
    {
        var target = new PropertyFilterService<Dto>();

        var filterDto = new FilterDto<Dto>
                        {
                            PropertyName = nameof(Dto.Id),
                            Operation    = Operation.Equal,
                            Value1        = 3,
                        };

        var actualExpression = target.BuildFilterExpression(filterDto);

        var actual = _sourceData.Where(actualExpression);

        var expected = new List<Dto>
                        {
                            new Dto { Id = 3 },
                        };

        actual.Should().BeEquivalentTo(expected);
    }


    [Test]
    public void TestBetweenValuesByOrder()
    {
        var target = new PropertyFilterService<Dto>();

        var filterDto = new FilterDto<Dto>
                        {
                            PropertyName = nameof(Dto.Id),
                            Operation    = Operation.Between,
                            Value1       = 2,
                            Value2       = 4,
                        };

        var actualExpression = target.BuildFilterExpression(filterDto);

        var actual = _sourceData.Where(actualExpression);

        var expected = new List<Dto>
                        {
                            new Dto { Id = 2 },
                            new Dto { Id = 3 },
                            new Dto { Id = 4 },
                        };

        actual.Should().BeEquivalentTo(expected);
    }

    [Test]
    public void TestBetweenValuesUnorder()
    {
        var target = new PropertyFilterService<Dto>();

        var filterDto = new FilterDto<Dto>
                        {
                            PropertyName = nameof(Dto.Id),
                            Operation    = Operation.Between,
                            Value1       = 4,
                            Value2       = 2,
                        };

        var actualExpression = target.BuildFilterExpression(filterDto);

        var actual = _sourceData.Where(actualExpression);

        var expected = new List<Dto>
                        {
                            new Dto { Id = 2 },
                            new Dto { Id = 3 },
                            new Dto { Id = 4 },
                        };

        actual.Should().BeEquivalentTo(expected);
    }
}
```