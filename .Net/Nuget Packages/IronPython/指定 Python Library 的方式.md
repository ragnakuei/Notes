# 指定 Python Library 的方式

```csharp
var setup   = Python.CreateRuntimeSetup( null );
var runtime = new ScriptRuntime( setup );
var engine  = Python.GetEngine( runtime );

var libSearchPaths = new List<string> { Path.Combine( AppDomain.CurrentDomain.BaseDirectory, "Python" ) };
engine.SetSearchPaths( libSearchPaths );

var     source = engine.CreateScriptSourceFromFile( Path.Combine( AppDomain.CurrentDomain.BaseDirectory, "Python", "test.py" ) );
dynamic scope  = engine.CreateScope();
var argv = new List<int>
{
    1,
    2
};

engine.GetSysModule().SetVariable( "argv", argv );
source.Execute( scope );
```