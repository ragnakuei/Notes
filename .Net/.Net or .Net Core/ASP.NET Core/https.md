# https

> dotnet dev-certs https --trust
 
https://stackoverflow.com/questions/52819808/could-not-get-any-response-in-postman

https://www.youtube.com/watch?v=vmTIEn7M6oQ


### 不使用 https 的做法

1. 把 Cookie 的 SecurePolicy 改為 CookieSecurePolicy.None
1. Program.cs 中，以下二行註解

    ```cs
    app.UseHsts();
    app.UseHttpsRedirection();
    ```