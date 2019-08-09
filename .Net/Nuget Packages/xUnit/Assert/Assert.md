# Assert

## Instance

## Collection

```csharp
///<summary>
/// 
///</summary>
Assert.<T>(T expected, IEnumerable<T> collection)
```

```csharp
///<summary>
/// 
///</summary>
Assert.Contains<T>(T expected, IEnumerable<T> collection, IEqualityComparer<T> comparer)
```

```csharp
///<summary>
/// 
///</summary>
Assert.Contains<T>(IEnumerable<T> collection, Predicate<T> filter)
```

```csharp
///<summary>
/// 
///</summary>
Assert.DoesNotContain()
```

```csharp
///<summary>
/// 確認 collection 的是否 1 對 1 符合 elementInspectors 的檢查
/// elementInspectors 檢查失敗時，要以 throw Exception 的方式
///</summary>
Assert.Collection<T>(IEnumerable<T> collection, params Action<T>[] elementInspectors)

// -----------------------------------------------------------------

// Sample1
Assert.Collection(new[] { 2, 3, 4 }
                , new Action<int>[]
                  {
                      i => { }
                    , i => { throw new Exception("Test Message"); }
                    , i => { }
                  });

// Sample1 : Test Fail Message 會列出錯誤元素的 index 及 Exception Message

Xunit.Sdk.CollectionException
Assert.Collection() Failure
Error during comparison of item at index 1
Inner exception: Test Message
   at TestProject.Tests.<>c.<Test1>b__0_1(Int32 i) in D:\Kuei\Projects\Test\TestLibrary\TestProject\Tests.cs:line 15
   at TestProject.Tests.Test1() in D:\Kuei\Projects\Test\TestLibrary\TestProject\Tests.cs:line 11

// -----------------------------------------------------------------

// Sample2
Assert.Collection(new[] { 2, 3 }
                , new Action<int>[]
                  {
                      i => { }
                    , i => { }
                    , i => { throw new Exception("Test Message"); }
                  });

// Sample2 : Test Fail Message 會檢查 collection 與 elementInspectors 的數量是否一致
Xunit.Sdk.CollectionException
Assert.Collection() Failure
Expected item count: 3
Actual item count:   2
   at TestProject.Tests.Test1() in D:\Kuei\Projects\Test\TestLibrary\TestProject\Tests.cs:line 11

```

```csharp
///<summary>
/// 判斷 collction 的每個元素 T 經過 action 處理是否皆不會發生 Exception
///</summary>
Assert.All<T>(IEnumerable<T> collection, Action<T> action)

// -----------------------------------------------------------------

// Sample
Assert.All(new[] { 2, 3, 4, 6, 7 }
         , i =>
           {
               if (i % 2 != 0)
               {
                   throw new Exception("Test");
               }
           });

// Test Fail Message : 會列出錯誤元素的 index
Xunit.Sdk.AllException
Assert.All() Failure: 2 out of 5 items in the collection did not pass.
[4]: System.Exception: Test
        at TestProject.Tests.<>c.<Test1>b__0_0(Int32 i) in D:\Kuei\Projects\Test\TestLibrary\TestProject\Tests.cs:line 18
        at Xunit.Assert.All[T](IEnumerable`1 collection, Action`1 action) in C:\BuildAgent\work\cb37e9acf085d108\src\xunit.assert\Asserts\CollectionAsserts.cs:line 31
[1]: System.Exception: Test
        at TestProject.Tests.<>c.<Test1>b__0_0(Int32 i) in D:\Kuei\Projects\Test\TestLibrary\TestProject\Tests.cs:line 18
        at Xunit.Assert.All[T](IEnumerable`1 collection, Action`1 action) in C:\BuildAgent\work\cb37e9acf085d108\src\xunit.assert\Asserts\CollectionAsserts.cs:line 31
   at TestProject.Tests.Test1() in D:\Kuei\Projects\Test\TestLibrary\TestProject\Tests.cs:line 11
```

## Exception

```csharp
///<summary>
/// 
///</summary>
Assert.Throws()
```

```csharp
///<summary>
/// 
///</summary>
Assert.Throws<>()
```

```csharp
///<summary>
/// 
///</summary>
Assert.ThrowsAny<>()
```

```csharp
///<summary>
/// 
///</summary>
Assert.ThrowsAsync()
```

```csharp
///<summary>
/// 
///</summary>
Assert.ThrowsAsync<>()
```


--- zzzz






```csharp
///<summary>
/// 
///</summary>
Assert.DoesNotContain()
```

```csharp
///<summary>
/// 
///</summary>
Assert.DoesNotMatch()
```

```csharp
///<summary>
/// 
///</summary>
Assert.Equal()
```

```csharp
///<summary>
/// 
///</summary>
Assert.Empty()
```



```csharp
///<summary>
/// 
///</summary>
Assert.InRange()
```

```csharp
///<summary>
/// 
///</summary>
Assert.IsType<>()
```

```csharp
///<summary>
/// 
///</summary>
Assert.IsType()
```

```csharp
///<summary>
/// 
///</summary>
Assert.IsAssignableFrom<>()
```

```csharp
///<summary>
/// 
///</summary>
Assert.IsAssignableFrom()
```

```csharp
///<summary>
/// 
///</summary>
Assert.IsNotType<>()
```

```csharp
///<summary>
/// 
///</summary>
Assert.IsNotType()
```

```csharp
///<summary>
/// 
///</summary>
Assert.Matches()
```

```csharp
///<summary>
/// 
///</summary>
Assert.Null()
```

```csharp
///<summary>
/// 
///</summary>
Assert.NotEmpty()
```

```csharp
///<summary>
/// 
///</summary>
Assert.NotEqual()
```

```csharp
///<summary>
/// 
///</summary>
Assert.NotNull()
```

```csharp
///<summary>
/// 
///</summary>
Assert.NotSame()
```

```csharp
///<summary>
/// 
///</summary>
Assert.NotInRange()
```

```csharp
///<summary>
/// 
///</summary>
Assert.NotStrictEqual()
```

```csharp
///<summary>
/// 
///</summary>
Assert.ProperSubset()
```

```csharp
///<summary>
/// 
///</summary>
Assert.ProperSuperset()
```

```csharp
///<summary>
/// 
///</summary>
Assert.PropertyChanged()
```

```csharp
///<summary>
/// 
///</summary>
Assert.Same()
```

```csharp
///<summary>
/// 
///</summary>
Assert.Single()
```

```csharp
///<summary>
/// 
///</summary>
Assert.Subset()
```

```csharp
///<summary>
/// 
///</summary>
Assert.Superset()
```

```csharp
///<summary>
/// 
///</summary>
Assert.StrictEqual()
```

