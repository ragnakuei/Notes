# asp.net core 的做法

參考資料：https://docs.microsoft.com/en-us/aspnet/core/security/data-protection/consumer-apis/password-hashing

```csharp
public class HashService
{
    public string Hash(string salt,string password)
    {
        if (string.IsNullOrWhiteSpace(password))
        {
            return string.Empty;
        }

        var byteArray = KeyDerivation.Pbkdf2(password,
                                                Convert.FromBase64String(salt),
                                                KeyDerivationPrf.HMACSHA256,
                                                10000,
                                                256 / 8);

        var hashed = Convert.ToBase64String(byteArray);

        return hashed;
    }
}
```