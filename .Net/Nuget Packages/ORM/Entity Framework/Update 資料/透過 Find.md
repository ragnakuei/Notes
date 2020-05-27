# 透過 Find

```csharp
public void Update(Group updateGroup)
{
    updateGroup.Created = DateTime.Now;

    using (var dbContext = DbContextFactory.CreateEfDbContext())
    {
        var groupInDb = dbContext.Groups.Find(updateGroup.Id);
        dbContext.Entry(groupInDb).CurrentValues.SetValues(updateGroup);
        dbContext.SaveChanges();
    }
}
```
