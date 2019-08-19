# CancellationTokenSource

## 設定 Timeout 的方式

單位是 milliseconds

1. 第一種

    ```csharp
    CancellationTokenSource cts = new CancellationTokenSource(100);
    ```

2. 第二種

    ```csharp
    CancellationTokenSource cts = new CancellationTokenSource();
    cts.CancelAfter(100);
    ```
