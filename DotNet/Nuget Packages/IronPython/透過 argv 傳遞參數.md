# 透過 argv 傳遞參數

- [透過 argv 傳遞參數](#%e9%80%8f%e9%81%8e-argv-%e5%82%b3%e9%81%9e%e5%8f%83%e6%95%b8)
  - [無回傳值](#%e7%84%a1%e5%9b%9e%e5%82%b3%e5%80%bc)
  - [有回傳值](#%e6%9c%89%e5%9b%9e%e5%82%b3%e5%80%bc)

---

## 無回傳值

```py
import sys

for arg in sys.argv:
    print arg
```

```c#
internal class Program
{
    public static void Main( string[] args )
    {
        var setup   = Python.CreateRuntimeSetup( null );
        var runtime = new ScriptRuntime( setup );
        var engine  = Python.GetEngine( runtime );
        var source  = engine.CreateScriptSourceFromFile( "./test.py" );
        var scope   = engine.CreateScope();
        var argv    = new List<int> { 1 ,2 };
        
        engine.GetSysModule().SetVariable( "argv", argv );
        var returnMsg = source.Execute( scope)?.ToString() ?? string.Empty;
        Console.WriteLine(returnMsg);
    }
}
```

## 有回傳值

