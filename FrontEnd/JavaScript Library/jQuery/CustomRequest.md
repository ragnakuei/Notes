# CustomRequest

-   將 `$.ajax` 包裝一層，避免太多的不必要語法
-   原範例，搭配 asp.net core mvc 使用
-   request Antiforgery 的部份，可參考[這裡](./../../../.Net/.Net%20Core/ASP.NET%20Core/Web%20API/套用%20Antiforgery.md)
-   支援透過 ajax 下載檔案 (含中文檔名處理)
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

        @* 傳入參數需要的 Properties：
           - RequireFullScreenLoading
           - Url
           - RequestBody
           - SuccessCallback
           - ErrorCallback(Optional)
           - CompleteCallback(Optional)
        *@
        self.Option = option;

        @* FullScreen Loading 功能 *@
        if (option.RequireFullScreenLoading)
        {
            self.FullScreenLoading = new CustomFullScreenLoading();
        }

        @* 用來防止多次觸發
           已有 request 正在處理中 => true
           沒有 request 正在處理中 => false
           僅限於同一功能，無法跨功能支援 !
        *@
        self.Waiting = false;

        @* 下面是 Functions *@

        self.Post = function()
        {
            // console.log(self.Option.ErrorCallback);
            // console.log(self.Option.RequestBody);

            try
            {
                if (self.Waiting)
                {
                    console.log('已有 request 正在等待回應中');
                    return;
                }

                self.Waiting = true;

                $.ajax(
                {
                    beforeSend: function(request)
                    {
                        request.setRequestHeader("@(ViewParameter.RequestVerificationToken)", Antiforgery.@(ViewParameter.RequestVerificationToken));

                        if (self.FullScreenLoading)
                        {
                            self.FullScreenLoading.Show();
                        }
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
                    self.Waiting = false;

                    self.PostRequestError(e);

                    if (self.Option.ErrorCallback)
                    {
                        self.Option.ErrorCallback(e.responseJSON);
                    }
                }).always(function (e)
                {
                    self.Waiting = false;

                    if (self.Option.CompleteCallback)
                    {
                        self.Option.CompleteCallback(e);
                    }

                    if (self.FullScreenLoading)
                    {
                        self.FullScreenLoading.Close();
                    }
                });
            }
            catch (e)
            {
                 alert('發生錯誤，請聯絡開發人員 !');
                 console.log(e);

                 self.Waiting = false;
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
                if (self.Waiting)
                {
                    console.log('已有 request 正在等待回應中');
                    return;
                }

                self.Waiting = true;

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
                    self.Waiting = false;

                    self.PostRequestError(e);

                    if (self.Option.ErrorCallback)
                    {
                        self.Option.ErrorCallback(e.responseJSON);
                    }
                }).always(function (e)
                {
                    self.Waiting = false;

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

        // 透過 ajax 下載檔案
        self.PostDownloadFile = function()
        {
            try
            {
                  const req = new XMLHttpRequest();
                  req.open("POST", self.Option.Url, true);
                  req.setRequestHeader("@(ViewParameter.RequestVerificationToken)", Antiforgery.@(ViewParameter.RequestVerificationToken));
                  req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
                  req.responseType = "blob";

                  req.onload = function (event)
                  {

                    if (req.status !== 200)
                    {
                        console.log(req);
                         alert('發生錯誤，請聯絡開發人員 !');
                         return;
                    }

                    const blob = req.response;
                    console.log(blob);

                    let filename = "default.file";
                    const disposition = req.getResponseHeader('Content-Disposition');
                    if (disposition && disposition.indexOf('attachment') !== -1)
                    {
                        // 從 response header content-disposition 的 filename*= 取出檔名
                        const filenameRegex = /filename[^;=\n]*\*=((['"]).*?\2|[^;\n]*)/;

                        // 從 response header content-disposition 的 filename= 取出檔名
                        // const filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;

                        const matches = filenameRegex.exec(disposition);
                        if (matches != null && matches[1])
                        {
                          filename = matches[1].replace(/['"]/g, '');

                          // 如果檔名包含了 UTF-8 並且是 url encode 過的，需要加上這一行，就可以支援中文檔名
                          filename = decodeURI(filename.replace('UTF-8',''));
                        }
                    }

                    const link=document.createElement('a');
                    link.href=window.URL.createObjectURL(blob);
                    link.download=filename;
                    link.click();

                  };

                  if (self.FullScreenLoading)
                  {
                      self.FullScreenLoading.Show();
                  }

                  const requestBody = ToFormData(self.Option.RequestBody);
                  req.send(requestBody);
            }
            catch (e)
            {
                alert('發生錯誤，請聯絡開發人員 !');
                console.log(e);
            }
            finally
            {
                if (self.FullScreenLoading)
                {
                   self.FullScreenLoading.Close();
                }
            }
        }

        function ToFormData(jsObject)
        {
            let formArray = [];

            const keys = Object.keys(jsObject);

             for (let i = 0; i < keys.length; i++)
             {
                 let propertyKey = keys[i];
                 formArray.push(propertyKey + "=" + jsObject[propertyKey]);
             }
             return formArray.join('&');
        }
    };
</script>
```

CustomFullScreenLoading.js

```html
<script>
    window.CustomFullScreenLoading = function()
    {
        const self = this;

        @* 下面是 Properties *@

        // self.Dom = $('#full-screen-loading');

        @* 下面是 Functions *@

        self.Show = function()
        {
            // self.Dom.fadeIn(300);

            console.log('Show FullScreenLoading');
        }

        self.Close = function()
        {
            // self.Dom.fadeOut(300);

            console.log('Hide FullScreenLoading');
        }
    }
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
