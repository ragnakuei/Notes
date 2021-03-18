# 從 string 取得 Type.md

分二個部份來看

## 相同的 Assembly

在相同的 Assembly 下，仍需給定 namespace !

```csharp
Type objectType = Type.GetType("ConsoleApp3.Calculator2");
var calculator = Activator.CreateInstance(objectType) as Calculator2;

var result = calculator.Add(1,2);

Console.WriteLine(result);
```

## 不同的 Assembly

在不相同的 Assembly 下
- Assembly 為 ClassLibrary
- NameSpace 為 ClassLibraryTest
- Class 為 Calculator

```csharp
Type objectType = Type.GetType("ClassLibraryTest.Calculator,ClassLibrary");
var calculator = Activator.CreateInstance(objectType) as Calculator;

var result = calculator.Add(1,2);

Console.WriteLine(result);
```
