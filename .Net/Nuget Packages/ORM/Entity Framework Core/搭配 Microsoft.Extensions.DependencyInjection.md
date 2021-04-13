# 搭配 Microsoft.Extensions.DependencyInjection

## 給定 Lifetime 的方式

```csharp
services.AddDbContext<TestDbContext>(options =>
                                        {
                                            var connectionString = configuration.GetConnectionString("DefaultConnection");

                                            options.UseSqlServer(connectionString);

                                            options.UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking);
                                        },
                                        contextLifetime: ServiceLifetime.Transient,
                                        ServiceLifetime.Transient);
```