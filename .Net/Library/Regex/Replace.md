# Replace

```csharp
var input = "0a1b2bc3d4e5f6g7h8i9j0k";

var regexPattern = @"[0-9]";
Regex.Replace(input, regexPattern, string.Empty).Dump();
```

```csharp
var input = "a1b2bc3d4e5f6g7h8i9j0k";

var regexPattern = @"[0-9]";
var rx = new Regex(regexPattern, RegexOptions.IgnoreCase);
string result = rx.Replace(input, string.Empty);

result.Dump();
```
