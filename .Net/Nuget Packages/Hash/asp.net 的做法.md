# asp.net 的做法

```csharp
// return ComputeHash(password, new MD5CryptoServiceProvider());
return ComputeHash(password, new SHA256CryptoServiceProvider());

public string ComputeHash(string input, HashAlgorithm algorithm)
{
    var inputBytes = Encoding.UTF8.GetBytes(input);
    var data = algorithm.ComputeHash(inputBytes);

    var stringBuilder = new StringBuilder();
    for (int i = 0; i < data.Length; i++)
    {
        stringBuilder.Append(data[i].ToString("x2"));
    }

    return stringBuilder.ToString();
}
```