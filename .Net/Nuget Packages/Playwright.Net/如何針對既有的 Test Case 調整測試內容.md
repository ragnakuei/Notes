# 如何針對既有的 Test Case 調整測試內容

參考資料：
[Debugging Tests](https://playwright.dev/dotnet/docs/running-tests#debugging-tests)

要點：

1. 以下面指令執行測試時，就會開啟 Playwright Inspector 及 Browser

    ```bash
    PWDEBUG=1
    dotnet test
    ```

    在 Rider 內執行無效 !
    在 cmd 內執行有效 !

    ```batch
    set PWDEBUG=1
    dotnet test
    ```

1. 要調有既有的 Test Case 進行測行，首先要將下面的語法加到該 Test Case 中

    ```cs
    await Page.PauseAsync();
    ```

    再以下面的指令執行測試，就可以在測試過程中暫停，並且可以在瀏覽器中進行操作

    ```bash
    # 執行執行的測試
    dotnet test --filter FullyQualifiedName=PlaywrightTests.Tests.MyTest
    ```

1. Playright Inspector 及 Browser 啟動後，會是未執行測試的狀態，要開始執行測試，要點選 Inspector 中的 `▶️` 按鈕

1. 當執行到 `await Page.PauseAsync();` 時，會暫停執行，並且可以在瀏覽器中進行操作

1. 可以按下 Record 按鈕，就可以在上述的情境下，進行開始錄製操作

1. 操作後，可以將複製所需要程式碼，貼到既有的 Test Case 中
