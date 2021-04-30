# [Random](https://docs.microsoft.com/en-us/dotnet/api/system.random?view=net-5.0)

## [new Random()](https://docs.microsoft.com/en-us/dotnet/api/system.random.-ctor?System_Random__ctor)

- 以 system clock 做為 seed
- 

## [new Random(int seed)](https://docs.microsoft.com/en-us/dotnet/api/system.random.-ctor?System_Random__ctor_System_Int32_)

-   可以給定 seed
-   但是 seed 一樣時，實際上產出結果的順序是一致的

    -   可以想成，seed 只是亂數表的編號
    -   如果編號一致，則取出的順序就會相同

-   最佳實作

    ```csharp
    var r = new Random(Guid.NewGuid().GetHashCode())
    ```
