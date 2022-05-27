# CascadingParameter

- 讓被包住的 Blazor Component 都可以接收到 CascadingValue 給定的資料
- 可以做為某個區塊內，狀態的保存器
- [給定第二組以上的參數，就用 nested 的方式給定就可以](https://docs.microsoft.com/en-us/aspnet/core/blazor/components/cascading-values-and-parameters#cascade-multiple-values)

### 範例 01

- 呼叫端

    ```cs
    @page "/Example2"
    <p>Example2</p>

    <div>
        <CascadingValue Name="CPValue" Value="_count">
            @if (_count % 2 == 0)
            {
                <Test2></Test2>
            }
            else
            {
                <Test3></Test3>
            }
        </CascadingValue>
    </div>

    <div>
        Count:@_count
    </div>

    <button @onclick="() => _count++">Pluls Count</button>


    @code {
        private int _count = 0;
    }
    ```

- Test2 / Test3 Blazor Component

    Test2 / Test3 就只差在文字不同，其餘皆相同

    ```cs
    <p>Test2</p>
    <p>@CPValue</p>


    @code {
        [CascadingParameter(Name = "CPValue")]
        public int CPValue { get; set; }
    }
```
