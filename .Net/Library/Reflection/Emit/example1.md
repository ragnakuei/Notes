# example1

建立 method 並轉成 delegate 來執行 !

```csharp
public class Test
{
    private delegate int HelloInvoker(string message, int returnValue);

    public void Run()
    {
        var argsTypes = new [] { typeof(string), typeof(int) };

        var hello = new DynamicMethod("Hello",     // method name
                                        typeof(int),      // return type
                                        argsTypes,        // args types
                                        typeof(Test).Module);

        var writeStringArgs = new[] { typeof(string) };
        var writeString     = typeof(Console).GetMethod(nameof(Console.WriteLine), writeStringArgs);

        var il = hello.GetILGenerator();

        // 傳入參數第 0 個
        il.Emit(OpCodes.Ldarg_0);
        // 以上述參數用來呼叫 writeString 這個 MethodInfo
        il.EmitCall(OpCodes.Call, writeString, null);

        il.Emit(OpCodes.Ldarg_1);
        // 以上述參數來做為回傳值
        il.Emit(OpCodes.Ret);

        // 以下二種寫法都可以
        // var hi = (HelloInvoker)hello.CreateDelegate(typeof(HelloInvoker));
        var hi = hello.CreateDelegate<HelloInvoker>();

        var returnValue = hi("\r\nHello, World!", 42);
        Console.WriteLine("Executing delegate hi(\"Hello, World!\", 42) returned {0}", returnValue);

        // retval = hi("\r\nHi, Mom!", 5280);
        // Console.WriteLine("Executing delegate hi(\"Hi, Mom!\", 5280) returned {0}", retval);
        //
        // object[] invokeArgs = { "\r\nHello, World!", 42 };
        // object   objRet     = hello.Invoke(null, invokeArgs);

        // Console.WriteLine("hello.Invoke returned {0}", objRet);
    }
}
```

大概就是下面這個意思

```csharp
private int Hello(string message, int returnValue)
{
    Console.WriteLine(message);
    return returnValue;
}
```