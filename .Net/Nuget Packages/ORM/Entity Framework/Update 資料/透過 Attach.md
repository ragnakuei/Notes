# 透過 Attach

Attach 的更新步驟是：
- 直接將 attach 的整包資料(必須包含 PK 與 關聯資料)
- 一次將所有 State 改為 修改 ( EntityState.Modified )
- 呼叫 SaveChanges() 時，進行一次更新

### 範例一

```csharp
public void Update(Group updateGroup)
{
    updateGroup.Created = DateTime.Now;
    
    using (var dbContext = DbContextFactory.CreateEfDbContext())
    {
        var groupInDb = dbContext.Groups.Attach(updateGroup);
        
        var entry = dbContext.Entry(groupInDb);
        entry.State = EntityState.Modified;
        
        dbContext.SaveChanges();
    }
}
```

