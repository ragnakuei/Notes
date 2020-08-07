# Key

[HasKey](https://www.learnentityframeworkcore.com/configuration/fluent-api/haskey-method)

### 範例

```csharp
builder.HasKey(x => new
                    {
                        x.Id,
                    })
        .IsClustered();
```

## ForeignKey

要先建立好對應 Table 的 Property

> 待釐清：被指向的 Column 似乎不能加上 `UseIdentityColumn()` 的設定

### one to one 範例

User.Id → Role.Id

> 這個語意上是錯的

要先在 User 中建立好對應 Role 的 Property

```csharp
public Role Role { get; set; }
```

就可以透過下面的語法建立 one to one Relation

```csharp
builder.HasOne(x => x.Role)
       .WithOne()
       .IsRequired()
       .HasConstraintName($"IX_{nameof(User)}_{nameof(User.RoleId)}_{nameof(Role)}_{nameof(Role.Id)}")
       .HasForeignKey<Role>(x => x.Id);
```

### one to one 範例 - self reference

如果是自體關聯的話，要用以下語法

```csharp
builder.HasOne(x => x.Creater)
       .WithOne()
       .IsRequired()
       .HasPrincipalKey<User>(x => x.Guid)
       .HasConstraintName($"IX_{nameof(User)}_{nameof(User.CreaterGuid)}_{nameof(User)}_{nameof(User.Guid)}")
       .OnDelete(DeleteBehavior.NoAction);
```

### one to many 範例

one Role.Id → many User.RoleId

```csharp
builder.HasOne(x => x.Role)
        .WithMany()
        .IsRequired()
        .HasConstraintName($"IX_{nameof(User)}_{nameof(User.RoleId)}_{nameof(Role)}_{nameof(Role.Id)}")
        .HasForeignKey(x => x.RoleId);
```
