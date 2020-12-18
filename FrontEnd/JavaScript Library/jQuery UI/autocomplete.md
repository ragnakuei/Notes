# [autocomplete](https://jqueryui.com/autocomplete/)

-   [jQuery UI min Js](https://code.jquery.com/ui/1.12.1/jquery-ui.min.js)
-   [jQuery UI min Css](https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.min.css)
-   [ui-anim_basic_16x16.gif](https://github.com/jquery/codeorigin.jquery.com/blob/master/cdn/ui/1.8.2/themes/base/images/ui-anim_basic_16x16.gif)
-   搭配 [CustomRequest](./../jQuery/CustomRequest.md)

## remote 範例

response 需要的結
- id
- label - 下拉選單顯示的文字
- value - 選擇項目後，所顯示的文字

### 包裝語法

-   `optionNameSpace` 定義給 `CustomAutoComplete` 呼叫的 object namespace
-   `optionSourceNameSpace` 定義給 `CustomRequest` 呼叫的 object namespace

```csharp
@* <link rel="stylesheet" href="~/lib/jquery-ui/jquery-ui.min.css"> *@
<style>
    .ui-autocomplete-loading {
        background: white url("/lib/jquery-ui/ui-anim_basic_16x16.gif") right center no-repeat;
    }
</style>
<script>

    @* 因為需要一開始就註冊 option 內的 dom 事件，所以請把 new CustomAutoComplete(initialOption) 放在最後一行 *@
    window.CustomAutoComplete = function(initialOption) {

        const self = this;

        @* option 需要的 properties：
                1. TriggerDomId                   - 註冊 AutoComplete 的 Dom Id
                2. Search(requestBody, response)  - 進行 Remote AutoComplete 使用的取資料的方式
                3. StoreDomId                     - 選取下拉選單後會把 item.Id 放至 StoreDomId 的 value 中
                4. SelectedStatus : boolean       - 用來判斷是否已選取下拉選單項目，特別是用於 編輯頁面
                5. AutoCompleteSuccessCallback(selectedItem)  - 選取下拉選單後會執行的 callback
        *@
        const option = initialOption;

        @* Enter = 13
           Tab = 9
           Shift = 16
           Ctrl = 17
           Alt = 18
           按下這二個鍵，不會清空 AutoComplete 的內容
        *@
        const ignoreKeyCodesWhenKeyDown = [ 9, 13, 16, 17, 18 ];

        @* 註冊 TriggerDomId 使用 jQuery UI AutoComplete *@
        $("#" + option.TriggerDomId).autocomplete({
            source: option.Search,
            minLength: 1,
            select: function( e, selectTarget ) {

                @* console.log("id: " + selectTarget.item.id + " ,label: " + selectTarget.item.label + " ,value: " + selectTarget.item.value); *@

                $('#' + option.StoreDomId).val(selectTarget.item.id);
                option.SelectedStatus = true;

                if (option.AutoCompleteSuccessCallback)
                {
                    option.AutoCompleteSuccessCallback(selectTarget.item);
                }
            }
        });

        @* 只要輸入新的字元，就讓 TriggerDomId 清空原本輸入的內容 *@
        $('#' + option.TriggerDomId).keydown(function(e) {

            if (ignoreKeyCodesWhenKeyDown.includes(e.keyCode))
            {
                return;
            }

            if (option.SelectedStatus === true)
            {
                @* console.log('清空 TriggerDomId 內容 及 刪除 StoreDomId 所儲存的值'); *@

                $('#' + option.TriggerDomId).val('');
                $('#' + option.StoreDomId).val('');
                option.SelectedStatus = false;
            }
        });
    };
</script>
```

### 範例

```csharp
<script>
    window.@(optionNameSpace) = {};
    @(optionNameSpace).TriggerDomId = '@(nameof(Model.Vendor))';
    @(optionNameSpace).StoreDomId = '@(nameof(Model.VendorGuid))';
    @(optionNameSpace).SelectedStatus = @(optionNameSpaceSelectedStatus.ToString().ToLower());
    @(optionNameSpace).Search = function (requestBody, response)
    {
        window.@(optionAjaxNameSpace) = {};
        @(optionAjaxNameSpace).Request = new CustomRequest(@(optionAjaxNameSpace));
        @(optionAjaxNameSpace).Url = '@Url.Action("AutoComplete", "Options")';
        @(optionAjaxNameSpace).RequestBody = {};
        @(optionAjaxNameSpace).RequestBody.AutoCompleteOption = '@(AutoCompleteOption.ValidVendors)';
        @(optionAjaxNameSpace).RequestBody.Keyword = requestBody.term;
        @(optionAjaxNameSpace).SuccessCallback = response;  @* 給 CustomRequest 回傳給 response 用，不用改 *@

        @(optionAjaxNameSpace).Request.Post();
    }
    @(optionNameSpace).CustomAutoComplete = new CustomAutoComplete(@(optionNameSpace));
</script>
```
