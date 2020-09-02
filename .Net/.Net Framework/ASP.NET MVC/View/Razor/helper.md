# helper

## 跨 View 使用的 helper

-   建立一個 View.cshtml 在 App_Code 中，假設主檔名叫 MyHelper
-   該 Helper 內的程式如下：

    ```csharp
    @helper Test(string s)
    {
        <p>@(s)</p>
    }
    ```

-   在不同的 View 上面，就可以用以下的語法來呼叫 helper

    ```csharp
    @MyHelper.Test("a")
    ```
