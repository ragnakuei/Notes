# 透過 argv 傳遞參數並取得回傳值

## 範例

- `test.py` 內容

    ```python
    import sys
    def Test():
        return sys.argv
    ```

- C# 程式：方式一：執行 .py script

    ```c#
    public static void Main( string[] args )
    {
        // 方式一：從 .py script
        var setup   = Python.CreateRuntimeSetup( null );
        var runtime = new ScriptRuntime( setup );
        var engine  = Python.GetEngine( runtime );
        
        var source  = engine.CreateScriptSourceFromFile( "./test.py" );
        dynamic scope   = engine.CreateScope();
        var argv    = new List<int> { 1 ,2 };
        
        engine.GetSysModule().SetVariable( "argv", argv );
        source.Execute( scope);
        
        var returnMsgs = scope.Test() as List<int> 
                    ?? new List<int>();
        
        foreach ( var returnMsg in returnMsgs )
        {
            Console.WriteLine(returnMsg);    
        }
        }
    ```

- C# 程式：方式二：給定 python script 字串

    ```csharp
    public static void Main( string[] args )
    {
        方式二：給定 python script 字串
                var script = @"
    import sys

    def Test():
        return sys.argv
    ";

                var     engine = Python.CreateEngine();
                dynamic scope  = engine.CreateScope();

                var argv = new List<int>
                {
                    1,
                    2
                };
                engine.GetSysModule().SetVariable( "argv", argv );

                engine.Execute( script, scope );

                var returnMsgs = scope.Test() as List<int>
                            ?? new List<int>();

                foreach ( var returnMsg in returnMsgs )
                {
                    Console.WriteLine( returnMsg );
                }
    }
    ```


