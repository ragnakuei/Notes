# 不同系統 Path.Combind


## 範例 01

```cs
using System.Runtime.InteropServices;

Console.WriteLine("Hello, World!");

var startLocation = string.Empty;

if (OperatingSystem.IsWindows())
{
    startLocation = "C:";
}
else if (OperatingSystem.IsMacOS()
      || OperatingSystem.IsLinux())
{
    startLocation = "/mnt/c";
}

var filePaths = new[] { startLocation, "temp", "internal-nlog.txt" };

var path = Path.Combine(filePaths);

Console.WriteLine("=============================================");
Console.WriteLine($"Path.DirectorySeparatorChar {Path.DirectorySeparatorChar}");
Console.WriteLine($"Path.AltDirectorySeparatorChar {Path.AltDirectorySeparatorChar}");
Console.WriteLine($"Path.VolumeSeparatorChar  {Path.VolumeSeparatorChar}");
Console.WriteLine("=============================================");
Console.WriteLine($"FilePath:{path}");
Console.WriteLine("=============================================");

var fs = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
using (var sr = new StreamReader(fs))
{
    var lineCount = 10;

    for (var i = 0; i < lineCount; i++)
    {
        var line = sr.ReadLine();
        Console.WriteLine(line);
    }
}


public static class OperatingSystem
{
    public static bool IsWindows() => RuntimeInformation.IsOSPlatform(OSPlatform.Windows);

    public static bool IsMacOS() => RuntimeInformation.IsOSPlatform(OSPlatform.OSX);

    public static bool IsLinux() => RuntimeInformation.IsOSPlatform(OSPlatform.Linux);
}
```

## 範例 02

[參考資料](https://www.796t.com/article.php?id=197016)

```cs
//方案1  執行時自帶
var path1 = Path.Combine("xxx", "yyy", "zzz");
//方案2  反斜槓 兩個平臺都可以用
var path2 = ("xxx/yyy/zzz");
//方案3 根據不同環境生成不同檔案路徑，GetRuntimeDirectory 自己編寫
//判斷平臺環境，路徑可以任意格式"xxx/yyy\\zzz" 
//實際上多個開發協同的時候就是比較混亂，開發環境都沒問題，整合的時候報錯頻繁
var path3 = GetRuntimeDirectory("xxx/yyy/zzz");
1、需要引用 System.Runtime.InteropServices

public static string GetRuntimeDirectory(string path)
{
    //ForLinux
    if (IsLinuxRunTime())
        return GetLinuxDirectory(path);
    //ForWindows
    if (IsWindowRunTime())
        return GetWindowDirectory(path);
    return path;
}

//OSPlatform.Windows監測執行環境
public static bool IsWindowRunTime()
{　　
    return System.Runtime.InteropServices.RuntimeInformation.IsOSPlatform(OSPlatform.Windows);
}

//OSPlatform.Linux執行環境
public static bool IsLinuxRunTime()
{
    return System.Runtime.InteropServices.RuntimeInformation.IsOSPlatform(OSPlatform.Linux);
}

public static string GetLinuxDirectory(string path)
{
    string pathTemp = Path.Combine(path);
    return pathTemp.Replace("\\", "/");
}
public static string GetWindowDirectory(string path)
{
    string pathTemp = Path.Combine(path);
    return pathTemp.Replace("/", "\\");
}
```