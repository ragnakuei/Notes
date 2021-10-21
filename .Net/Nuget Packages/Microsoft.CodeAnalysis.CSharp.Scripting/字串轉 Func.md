# 字串轉 Func

#### 範例

```cs
var str = "f => f.Split(\" \")[1]";
var func = await CSharpScript.EvaluateAsync<Func<string, string>>(str);
var firstWord = func("Hello World");

firstWord.Dump();
```