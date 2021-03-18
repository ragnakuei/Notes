# functions

與 helper 不同的點是，functions 主要是以 C# 角度來設計 method，所以回傳值，必須是 C# 物件 !

## 跨 View 使用的 functions

-   建立一個 View.cshtml 在 App_Code 中，假設主檔名叫 MyHelper
-   該 Helper 內的程式如下：

    ```csharp
    @functions
    {
        public static string Test(string s)
        {
            return s;
        }
    }`
    ```

-   在不同的 View 上面，就可以用以下的語法來呼叫 helper

    ```csharp
    @MyHelper.Test("a")
    ```
