# CustomRequest

-   將 `$.ajax` 包裝一層，避免太多的不必要語法
-   原範例，搭配 asp.net core mvc 使用
-   request Antiforgery 的部份，可參考[這裡](./../../../.Net/.Net%20Core/ASP.NET%20Core/Web%20API/套用%20Antiforgery.md)
-   延伸應用：[autocomplete](./../jQuery%20UI/autocomplete.md)

## 包裝語法

```csharp
<script>
    window.CustomRequest = {};
    CustomRequest.RequestFileLimitSize = @(ServerParameter.RequestBodyMaxSize);

    @* 傳入參數需要的 Properties：
          Url              - request url
          RequestBody      - request body
          SuccessCallback  - request 成功後會執行的 callback
          ErrorCallback(Optional) - request 失敗後會執行的 callback                          *@
    CustomRequest.Post  = function(obj){

        CustomRequest.ErrorCallback = obj.ErrorCallback;

        try {
           $.ajax({
               beforeSend: function(request) {
                   // 在 ajax 加上 Request Header 來處理 Antifogery
                   request.setRequestHeader("RequestVerificationToken"), Antiforgery.RequestVerificationToken);
               },
               url: obj.Url,
               data: obj.RequestBody,
               type: 'post',
               // dataType: jQueryParameter.DataType,
               // contentType: jQueryParameter.ContentType,
               success: obj.SuccessCallback,
               error: CustomRequest.PostRequestError,
           });
        }
        catch(e)
        {
            alert('發生錯誤，請聯絡開發人員 !');
            console.log(e);
        }
    }

    CustomRequest.CheckUploadFileSize = function(file) {
        if (file
         && file.size
         && file.size >= CustomRequest.RequestFileLimitSize)
        {
            const errorMessage = '@(Html.Raw(ErrorCode.GetErrorMessage(ErrorCode.E400007)))';
            alert(errorMessage);
            throw errorMessage;
        }
    }

    CustomRequest.PostFile  = function(obj){

        CustomRequest.ErrorCallback = obj.ErrorCallback;

        try {
           $.ajax({
               beforeSend: function(request) {
                  request.setRequestHeader("@(ViewParameter.RequestVerificationToken)", Antiforgery.@(ViewParameter.RequestVerificationToken));
               },
               url: obj.Url,
               data: obj.RequestBody,
               type: 'post',

               @* 以下二個為解決 Illegal invocation 的問題 *@
               processData: false,
               contentType : false,

               success: obj.SuccessCallback,
               error: CustomRequest.PostRequestError,
               complete: obj.CompleteCallback,
           });
        }
        catch(e)
        {
            alert('發生錯誤，請聯絡開發人員 !');
            console.log(e);
        }
    }

    CustomRequest.PostRequestError = function(jqXHR, textStatus, errorThrown)
    {
        if (jqXHR.status === 401)
        {
            window.location.href = '@Url.Action("Login", "Account")'
        }

        console.log(jqXHR);
        console.log(textStatus);
        console.log(errorThrown);
        console.log(jqXHR.responseJSON);

        if(jqXHR.responseJSON)
        if(jqXHR.responseJSON.Message)
        {
            alert(jqXHR.responseJSON.Message);
        }
        else
        {
            alert('發生錯誤，請聯絡開發人員');
        }

        console.log(CustomRequest.ErrorCallback);
        if(CustomRequest.ErrorCallback)
        {
            CustomRequest.ErrorCallback(jqXHR.responseJSON);
        }
    }

</script>
```

## 呼叫語法

```csharp
<script>
    window.VendorList = {};
    VendorList.Url = '@(Url.Action("GetList"))';
    VendorList.RequestBody = @Html.Raw(ViewHelpers.GenerateDefaultPageInfoDto(Model))
    VendorList.ReloadList = function() {
        VendorList.RequestBody.SearchVendorName = $('#searchVendorName').val();
        VendorList.RequestBody.SearchVendorTaxId = $('#searchVendorTaxId').val();

        // 這裡呼叫 CustomRequest
        CustomRequest.Post(VendorList);
    };
    VendorList.SortColumn = function(column, orderby) {
        VendorList.RequestBody.SortColumn = column;
        VendorList.RequestBody.SortColumnOrder = orderby;
        VendorList.ReloadList();
    };

    // 正常 Request 回應的地方
    VendorList.SuccessCallback = function (e){
        $('#vendorList').html(e.Data);
        VendorList.RequestBody.DataCount = e.PageInfo.DataCount;
    };
</script>
```
