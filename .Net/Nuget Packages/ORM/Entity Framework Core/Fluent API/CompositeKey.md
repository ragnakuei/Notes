# CompositeKey


```csharp
protected override void OnModelCreating(ModelBuilder modelBuilder)
{
    modelBuilder.Entity<GroupRole>()
                .HasKey(gr => new
                    {
                        gr.GroupId,
                        gr.RoleId
                    });
    
    modelBuilder.Entity<RouteRole>()
                .HasKey(gr => new
                    {
                        gr.RouteId,
                        gr.RoleId
                    });
    
    modelBuilder.Entity<UserGroup>()
                .HasKey(gr => new
                    {
                        gr.GroupId,
                        gr.UserId
                    });
}
```