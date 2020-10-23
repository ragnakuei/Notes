# CustomRequest

-   將 `$.ajax` 包裝一層，避免太多的不必要語法
-   原範例，搭配 asp.net core mvc 使用
-   request Antiforgery 的部份，可參考[這裡](./../../../.Net/.Net%20Core/ASP.NET%20Core/Web%20API/套用%20Antiforgery.md)
-   延伸應用：[autocomplete](./../jQuery%20UI/autocomplete.md)

## 包裝語法

```csharp
<script>
    @* 將 CustomRequest 設計為狀態不共用 *@
    window.CustomRequest = function(option)
    {
        const self = this;

        @* 下面是 Properties *@

        self.RequestFileLimitSize = @(ServerParameter.RequestBodyMaxSize);

        @* 傳入參數需要四個 Properties： Url, RequestBody, SuccessCallback, ErrorCallback(Optional), CompleteCallback(Optional) *@
        self.Option = option;

        @* 下面是 Functions *@

        self.Post = function()
        {
            // console.log(self.Option.ErrorCallback);
            // console.log(self.Option.RequestBody);

            try
            {
                $.ajax(
                {
                    beforeSend: function(request)
                    {
                        request.setRequestHeader("@(ViewParameter.RequestVerificationToken)", Antiforgery.@(ViewParameter.RequestVerificationToken));
                    },
                    url: self.Option.Url,
                    data: self.Option.RequestBody,
                    type: 'post',

                    // dataType: jQueryParameter.DataType,
                    // contentType: jQueryParameter.ContentType,
                }).done(function(e)
                {
                   self.Option.SuccessCallback(e);
                }).fail(function (e)
                {
                   self.PostRequestError(e);

                   if (self.Option.ErrorCallback)
                   {
                       self.Option.ErrorCallback(e.responseJSON);
                   }
                }).always(function (e){
                   if (self.Option.CompleteCallback)
                   {
                       self.Option.CompleteCallback(e);
                   }
                });
            }
            catch (e)
            {
                alert('發生錯誤，請聯絡開發人員 !');
                console.log(e);
            }
        }

        self.CheckUploadFileSize = function(file)
        {
            if (file &&
                file.size &&
                file.size >= self.RequestFileLimitSize)
            {
                const errorMessage = '@(Html.Raw(ErrorCode.GetErrorMessage(ErrorCode.E400007)))';
                alert(errorMessage);
                throw errorMessage;
            }
        }

        self.PostFile = function(file)
        {
            self.CheckUploadFileSize(file);

            try
            {
                $.ajax(
                {
                    beforeSend: function(request)
                    {
                        request.setRequestHeader("@(ViewParameter.RequestVerificationToken)", Antiforgery.@(ViewParameter.RequestVerificationToken));
                    },
                    url: self.Option.Url,
                    data: self.Option.RequestBody,
                    type: 'post',

                    @* 以下二個為解決 Illegal invocation 的問題 *@
                    processData: false,
                    contentType: false,
                }).done(function(e)
                {
                   self.Option.SuccessCallback(e);
                }).fail(function (e)
                {
                   self.PostRequestError(e);

                   if (self.Option.ErrorCallback)
                   {
                       self.Option.ErrorCallback(e.responseJSON);
                   }
                }).always(function (e){
                   if (self.Option.CompleteCallback)
                   {
                       self.Option.CompleteCallback(e);
                   }
                });
            }
            catch (e)
            {
                alert('發生錯誤，請聯絡開發人員 !');
                console.log(e);
            }
        }

        self.PostRequestError = function(jqXHR, textStatus, errorThrown)
        {
            if (jqXHR.status === 401)
            {
                window.location.href = '@Url.Action("Login", "Account")'
            }

            // console.log(jqXHR);
            // console.log(textStatus);
            // console.log(errorThrown);
            console.log(jqXHR.responseJSON);

            if (jqXHR.responseJSON
            && jqXHR.responseJSON.Message)
            {
                alert(jqXHR.responseJSON.Message);
            }
            else
            {
                alert('發生錯誤，請聯絡開發人員');
            }

            // console.log(self);
        }
    };
</script>
```

## 呼叫語法

```csharp
<script>
    window.VendorList = {};
    VendorList.Request = new CustomRequest(VendorList);
    VendorList.Url = '@(Url.Action("GetList"))';
    VendorList.RequestBody = @Html.Raw(ViewHelpers.GenerateDefaultPageInfoDto(Model))
    VendorList.SearchList = function()
    {
        VendorList.RequestBody.SearchVendorName = $('#SearchVendorName').val();
        VendorList.RequestBody.SearchVendorTaxId = $('#SearchVendorTaxId').val();

        VendorList.Reload();
    };
    VendorList.SortColumn = function(column, orderby)
    {
        VendorList.RequestBody.SortColumn = column;
        VendorList.RequestBody.SortColumnOrder = orderby;
        VendorList.SearchList();
    };
    VendorList.SuccessCallback = function(e)
    {
        console.log(e);

        $('#vendorList').html(e.Data);
        VendorList.SavePageInfoToRequestBody(e.PageInfo);
        initialPageSelect();
    };
    VendorList.Reload = function(e)
    {
        VendorList.Request.Post();
    }
    VendorList.SavePageInfoToRequestBody = function(pageInfo)
    {
    var SearchVendorName = VendorList.RequestBody.SearchVendorName;
    var SearchVendorTaxId = VendorList.RequestBody.SearchVendorTaxId;

    VendorList.RequestBody = pageInfo;

    VendorList.RequestBody.SearchVendorName = SearchVendorName;
    VendorList.RequestBody.SearchVendorTaxId = SearchVendorTaxId;
    }
</script>
```
