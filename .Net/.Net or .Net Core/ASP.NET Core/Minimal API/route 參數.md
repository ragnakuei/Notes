# route 參數

```cs
app.MapGet("/users/{userId}/books/{bookId}",
           (int userId, int bookId) => $"The user id is {userId} and book id is {bookId}");
```


