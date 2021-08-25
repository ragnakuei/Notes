# 計算 checksum

## 純後端

下面四種語法的計算結果相同

```csharp
var fileName = @"c:\temp\internal-nlog.txt";
var checksum = string.Empty;

using (var md5 = MD5.Create())
using (var stream = File.OpenRead(fileName))
{
    var hash = md5.ComputeHash(stream);
    hash.Dump();
    checksum = BitConverter.ToString(hash).Replace("-", "").ToLowerInvariant();
}

checksum.Dump();
```

```csharp
var fileName = @"c:\temp\internal-nlog.txt";
var checksum = string.Empty;

using (var md5 = MD5.Create())
{
    var hash = md5.ComputeHash(File.ReadAllBytes(fileName));
    hash.Dump();
    checksum = BitConverter.ToString(hash).Replace("-", "").ToLowerInvariant();
}

checksum.Dump();
```

```csharp
void Main()
{
    var fileName = @"c:\temp\internal-nlog.txt";
    var checksum = string.Empty;
    
    using (var md5 = MD5.Create())
    {
        var hash = md5.ComputeHash(File.ReadAllBytes(fileName));
        hash.Dump();
        checksum = BytesToHex(hash);
    }
    
    checksum.Dump();
}

private string BytesToHex(byte[] bytes)
{
    return String.Concat(Array.ConvertAll(bytes, x => x.ToString("X2")));
}
```

從下面的語法可以看出，預設讀檔是用 UTF8 

```csharp
var fileName = @"c:\temp\internal-nlog.txt";
var checksum = string.Empty;

using (var md5 = MD5.Create())
{
    var byteArray = Encoding.UTF8.GetBytes(File.ReadAllText(fileName));
    //var byteArray = Encoding.ASCII.GetBytes(File.ReadAllText(fileName));
    var hash = md5.ComputeHash(byteArray);
    hash.Dump();
    checksum = BitConverter.ToString(hash).Replace("-", "").ToLowerInvariant();
}

checksum.Dump();
```

## 搭配前端

[前端 md5](../../../FrontEnd/JavaScript%20Library/hash/md5.md)
