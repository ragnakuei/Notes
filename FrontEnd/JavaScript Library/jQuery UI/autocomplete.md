# [autocomplete](https://jqueryui.com/autocomplete/)

-   [jQuery UI min Js](https://code.jquery.com/ui/1.12.1/jquery-ui.min.js)
-   [jQuery UI min Css](https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.min.css)
-   [ui-anim_basic_16x16.gif](https://github.com/jquery/codeorigin.jquery.com/blob/master/cdn/ui/1.8.2/themes/base/images/ui-anim_basic_16x16.gif)
-   搭配 [CustomRequest](./../jQuery/CustomRequest.md)

## remote 範例

### 包裝語法

-   `optionNameSpace` 定義給 `CustomAutoComplete` 呼叫的 object namespace
-   `optionSourceNameSpace` 定義給 `CustomRequest` 呼叫的 object namespace

```csharp
<link rel="stylesheet" href="~/lib/jquery-ui/jquery-ui.min.css">
<script src="~/lib/jquery-ui/jquery-ui.min.js"
        asp-append-version="true"
        crossorigin="use-credentials"></script>
<style>
    .ui-autocomplete-loading {
        background: white url("/lib/jquery-ui/ui-anim_basic_16x16.gif") right center no-repeat;
    }
</style>
<script>
    window.CustomAutoComplete = {};

    @*
        用來可以對一個畫面上的多個 dom 來實作 autocomplete 功能
        Key Value Pair
            - Key : TriggerDomId
            - Value : obj
        透過 Key 找到 obj.StoreDomId 來刪除該 Dom 的 value
    *@
    CustomAutoComplete.Store = {};

    @* obj 需要的 properties：
            1. TriggerDomId                   - 註冊 AutoComplete 的 Dom Id
            2. Search(requestBody, response)  - 進行 Remote AutoComplete 使用的取資料的方式
            3. StoreDomId                     - 選取下拉選單後會把 item.Id 放至 StoreDomId 的 value 中
            4. SelectedStatus : boolean       - 用來判斷是否已選取下拉選單項目，特別是用於 編輯頁面
            5. AutoCompleteSuccessCallback(selectedItem)  - 選取下拉選單後會執行的 callback
    *@

    CustomAutoComplete.Register = function(obj){

        CustomAutoComplete.Store[obj.TriggerDomId] = obj;

        $("#" + obj.TriggerDomId).autocomplete({
            source: obj.Search,
            minLength: 1,
            select: function( e, selectTarget ) {

                @* console.log("id: " + selectTarget.item.id + " ,label: " + selectTarget.item.label + " ,value: " + selectTarget.item.value); *@

                const targetObj = CustomAutoComplete.Store[e.target.id];

                $('#' + targetObj.StoreDomId).val(selectTarget.item.id);
                targetObj.SelectedStatus = true;

                if (targetObj.AutoCompleteSuccessCallback)
                {
                    targetObj.AutoCompleteSuccessCallback(selectTarget.item);
                }
            }
        });

        @* Enter = 13、Tab = 9*@
        CustomAutoComplete.ignoreKeyCodesWhenKeyDown = [ 9, 13 ];

        $('#' + obj.TriggerDomId).keydown(function(e) {

            if (CustomAutoComplete.ignoreKeyCodesWhenKeyDown.includes(e.keyCode))
            {
                return;
            }

            const targetObj = CustomAutoComplete.Store[e.target.id];

            if (targetObj.SelectedStatus === true)
            {
                @* console.log('清空 TriggerDomId 內容 及 刪除 StoreDomId 所儲存的值'); *@

                $('#' + obj.TriggerDomId).val('');
                $('#' + obj.StoreDomId).val('');
                targetObj.SelectedStatus = false;
            }
        });

        console.log('CustomAutoComplete.Register obj:' );
        console.log(obj);
    }
</script>
```

### 範例

```csharp
<script>
    window.@(optionNameSpace) = {};
    @(optionNameSpace).TriggerDomId = '@(nameof(Model.Vendors))';
    @(optionNameSpace).StoreDomId = '@(nameof(Model.VendorGuid))';
    @(optionNameSpace).Search = function (requestBody, response)
    {
        window.@(optionSourceNameSpace) = {};
        @(optionSourceNameSpace).Url = '@Url.Action("Post", "Options")';
        @(optionSourceNameSpace).StoreDomId = '@(nameof(Model.VendorGuid))';
        @(optionSourceNameSpace).RequestBody = {};
        @(optionSourceNameSpace).RequestBody.Option = '@(Option.ValidVendors)';
        @(optionSourceNameSpace).RequestBody.Keyword = requestBody.term;
        @(optionSourceNameSpace).SuccessCallback = response;  @* 給 CustomRequest 回傳給 response 用，不用改 *@

        CustomRequest.Post(@(optionSourceNameSpace));
    }

    CustomAutoComplete.Register(@optionNameSpace);
</script>
```
