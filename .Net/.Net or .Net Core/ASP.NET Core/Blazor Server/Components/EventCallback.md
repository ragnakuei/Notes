# [EventCallback](https://docs.microsoft.com/en-us/aspnet/core/blazor/components/event-handling#eventcallback)

child component emit event to parent component

### 範例01 - 透過 EventCallBack\<T> 傳遞資料

- Child Component

    ```html
    <a class="page-link"
        href=""
        @onclick:preventDefault
        @onclick="() => ToPage(0)">
        Prev
    </a>
    ```

    ```csharp
    public partial class Pagination : ComponentBase
    {
        [Parameter]
        public PageInfoDto PageInfo { get; set; }

        [Parameter]
        public EventCallback<int> OnPageChanged {get; set;}

        private async Task ToPage(int pageNo)
        {
            await OnPageChanged.InvokeAsync(pageNo);
        }
    }
    ```

- Parent Component

    ```csharp
    <Pagination PageInfo="PageInfoDto" PageOffset="3" OnPageChanged="ToPage" />

    @code {
        public PageInfoDto PageInfo { get; set; }

        private void GetList()
        {
            ResponseDto = ManageUserService?.GetList(new ListDto
                                                    {
                                                        PageNo   = ResponseDto.PageNo,
                                                        PageSize = ResponseDto.PageSize,
                                                    });
        }

        private void ToPage(int pageNo)
        {
            ResponseDto.PageNo = pageNo;
            GetList();
        }
    }
    ```

### 範例02 - 利用 reference type 傳遞資料

- Child Component

    ```html
    <a class="page-link"
        href=""
        @onclick:preventDefault
        @onclick="() => ToPage(0)">
        Prev
    </a>
    ```

    ```csharp
    public partial class Pagination : ComponentBase
    {
        [Parameter]
        public PageInfoDto PageInfo { get; set; }

        [Parameter]
        public EventCallback OnPageChanged {get; set;}

        private async Task ToPage(int pageNo)
        {
            // 資料可直接同步回 parent component
            PageInfo.PageNo = pageNo;
            
            await OnPageChanged.InvokeAsync();
        }
    }
    ```

- Parent Component

    ```csharp
    <Pagination PageInfo="PageInfoDto" PageOffset="3" OnPageChanged="GetList" />

    @code {
        public PageInfoDto PageInfo { get; set; }

        private void GetList()
        {
            ResponseDto = ManageUserService?.GetList(new ListDto
                                                    {
                                                        PageNo   = ResponseDto.PageNo,
                                                        PageSize = ResponseDto.PageSize,
                                                    });
        }
    }
    ```