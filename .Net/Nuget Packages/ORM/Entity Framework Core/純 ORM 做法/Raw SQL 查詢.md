# Raw SQL 查詢

- 可在 DbContext 中宣告 DbSet\<T> Property

    ```csharp
    public DbSet<SpDto> SpDtos { get; set; }
    ```

- 在 OnModelCreating() 中，必須宣告 Entity Model

    ```csharp
    modelBuilder.Entity<OrderSpDto>()
                .HasNoKey();
    ```

    如果未宣告 Entity Model，就會出現以下錯誤訊息

    ```
    InvalidOperationException: Cannot create a DbSet for 'SpDto' because this type is not included in the model for the context.
    ```

- 查詢方式
  - 可使用 DbContext.SpDtos.FromRawSql()
  - 可使用 DbContext.Set\<SpDto>().FromRawSql()