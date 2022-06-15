# CascadingParameter

-   讓被包住的 Blazor Component 都可以接收到 CascadingValue 給定的資料
-   [給定第二組以上的參數，就用 nested 的方式給定就可以](https://docs.microsoft.com/en-us/aspnet/core/blazor/components/cascading-values-and-parameters#cascade-multiple-values)
-   可以做為某個區塊內，狀態的保存器
-   如果想要將 child component 內的資料同步至 parent component
    -   Value Type / String 不會同步更新
    -   其餘的 Reference Type 會在離開該 component 後，同步更新
        -   在 chile component 呼叫 StateHasChanged() 不會立即更新至 parent component
    -   可以考慮直接用 [In-memory state container service](../../State/In-memory%20state%20container%20service/範例%2001.md)，會簡單很多 !
