# Collection

集合的判斷主要還是依照順序比較，要特別注意。

## Assert.Contains

 檢查 collection 是否包含了 expected

```csharp
Assert.Contains<T>(T expected, IEnumerable<T> collection)
Assert.Contains<T>(T expected, IEnumerable<T> collection, IEqualityComparer<T> comparer)
```

檢查 collection 以 filter 是否找得到 T

```csharp
Assert.Contains<T>(IEnumerable<T> collection, Predicate<T> filter)
```

## Assert.DoesNotContains

 檢查 collection 是否不包含 expected

```csharp
Assert.DoesNotContains<T>(T expected, IEnumerable<T> collection)
Assert.DoesNotContains<T>(T expected, IEnumerable<T> collection, IEqualityComparer<T> comparer)
```

檢查 collection 以 filter 是否找得不到 T

```csharp
Assert.DoesNotContains<T>(IEnumerable<T> collection, Predicate<T> filter)
```

## Assert.Empty

檢查 collection 不為 null 而是 Empty 的情況

```csharp
Assert.Empty(IEnumerable collection)
```

## Assert.NotEmpty

檢查 collection 不為 null 也不是 Empty 的情況

```csharp
Assert.NotEmpty(IEnumerable collection)
```

## Assert.Equal

依序比較 expected 與 actual 是否相等。

```csharp
Assert.Equal<T>(IEnumerable<T> expected, IEnumerable<T> actual)
Assert.Equal<T>(IEnumerable<T> expected, IEnumerable<T> actual, IEqualityComparer<T> comparer)
```

## Assert.NotEqual

依序比較 expected 與 actual 是否不相等。

> 如果元素內容相等，順序不同，NotEqual 會驗証通過。

```csharp
Assert.NotEqual<T>(IEnumerable<T> expected, IEnumerable<T> actual)
Assert.NotEqual<T>(IEnumerable<T> expected, IEnumerable<T> actual, IEqualityComparer<T> comparer)
```

## Assert.Single

檢查 collection 只有一個元素。

> predicate 當 filter 用，經過 filter 後只能有一個元素。

```csharp
Assert.Single(IEnumerable collection)
Assert.Single<T>(IEnumerable<T> collection, Predicate<T> predicate)
```

## Assert.Collection

確認 collection 的是否 1 對 1 符合 elementInspectors 的檢查。

```csharp
Assert.Collection<T>(IEnumerable<T> collection, params Action<T>[] elementInspectors)
```

### Sample：檢查失敗

elementInspectors 檢查失敗時，要以 throw Exception 的方式才可以被指定為檢查失敗。

> throw Exception 的方式，可用 xUnit Assert 的方式。

```csharp
Assert.Collection(new[] { 2, 3, 4 }
                , new Action<int>[]
                  {
                      i => { }
                  // , i => { throw new Exception("Test Message"); }
                     , i => Assert.True( i % 2 == 0 )
                    , i => { }
                  });
```

Test Fail Message 會列出錯誤元素的 index 及 Exception Message

```
Xunit.Sdk.CollectionException
Assert.Collection() Failure
Error during comparison of item at index 1
Inner exception: Test Message
   at TestProject.Tests.<>c.<Test1>b__0_1(Int32 i) in D:\Kuei\Projects\Test\TestLibrary\TestProject\Tests.cs:line 15
   at TestProject.Tests.Test1() in D:\Kuei\Projects\Test\TestLibrary\TestProject\Tests.cs:line 11
```

### Sample：collection 與 elementInspectors 的數量不一致

會檢查 collection 與 elementInspectors 的數量是否一致

```csharp
Assert.Collection(new[] { 2, 3 }
                , new Action<int>[]
                  {
                      i => { }
                    , i => { }
                 // , i => { throw new Exception("Test Message"); }
                    , i => Assert.False(true)
                  });
```

Test Fail Message：Xunit.Sdk.CollectionException

```
Assert.Collection() Failure
Expected item count: 3
Actual item count:   2
   at TestProject.Tests.Test1() in D:\Kuei\Projects\Test\TestLibrary\TestProject\Tests.cs:line 11

```

## Assert.All

判斷 collction 的每個元素 T 經過 action 處理是否皆不會發生 Exception

```csharp
Assert.All<T>(IEnumerable<T> collection, Action<T> action)
```

### Sample

```csharp
Assert.All(new[] { 2, 3, 4, 6, 7 }
         , i =>
           {
               if (i % 2 != 0)
               {
                   throw new Exception("Test");
               }
           });
```

Test Fail Message : 會列出錯誤元素的 index

```
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
