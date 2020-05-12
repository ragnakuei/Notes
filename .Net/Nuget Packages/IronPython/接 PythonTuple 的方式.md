# PythonTuple

將執行結果放到 List 中，每個 item 都是 `PythonTuple` 型別

## 範例

```csharp
public static void Main( string[] args )
{
    var setup   = Python.CreateRuntimeSetup( null );
    var runtime = new ScriptRuntime( setup );
    var engine  = Python.GetEngine( runtime );

    var     source = engine.CreateScriptSourceFromFile( "./test.py" );
    dynamic scope  = engine.CreateScope();
    source.Execute( scope );

    dynamic tmp = scope.Test();
    var returnMsgs = tmp as List;

    foreach ( PythonTuple returnMsg in returnMsgs )
    {
        foreach ( var msg in returnMsg )
        {
            Console.WriteLine( msg );
        }
    }
}
```
