# Property

## Identity

[Identity 指定方式](https://www.learnentityframeworkcore.com/configuration/fluent-api/valuegeneratedonadd-method)

## 設定 Identity

就算不設定 `UseIdentityColumn()` 其實也會啟用

```csharp
builder.Property(x => x.Id)
        .IsRequired()
        .UseIdentityColumn(1, 1)
        .HasComment("ID");
```

## 不設定 Identity

`ValueGeneratedNever()`

```csharp
builder.Property(x => x.Id)
        .IsRequired()
        .ValueGeneratedNever()
        .HasComment("ID");
```
