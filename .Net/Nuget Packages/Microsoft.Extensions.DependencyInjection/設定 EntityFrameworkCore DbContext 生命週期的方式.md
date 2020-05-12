# 設定 EntityFrameworkCore DbContext 生命週期的方式

下面程式是套件原始碼

而 contextLifetime 參數就是指定 DbContext 的生命週期

> 註： optionsLifetime 參數就是指定 透過 DbContextOptionsBuilder 產生的 DbContextOptions 生命週期

```csharp
/// <param name="contextLifetime"> The lifetime with which to register the DbContext service in the container. </param>
/// <param name="optionsLifetime"> The lifetime with which to register the DbContextOptions service in the container. </param>
/// <returns>
///     The same service collection so that multiple calls can be chained.
/// </returns>
public static IServiceCollection AddDbContext<TContext>(
    [NotNull] this IServiceCollection serviceCollection,
    [CanBeNull] Action<DbContextOptionsBuilder> optionsAction = null,
    ServiceLifetime contextLifetime = ServiceLifetime.Scoped,
    ServiceLifetime optionsLifetime = ServiceLifetime.Scoped)
    where TContext : DbContext
{
    return serviceCollection.AddDbContext<TContext, TContext>(optionsAction, contextLifetime, optionsLifetime);
}
```
