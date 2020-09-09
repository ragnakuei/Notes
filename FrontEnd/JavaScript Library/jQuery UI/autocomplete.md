# [autocomplete](https://jqueryui.com/autocomplete/)

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

    @* obj 需要的 Properties：
           1. TriggerDomId                   - 註冊 AutoComplete 的 Dom Id
           2. Search(requestBody, response)  - 進行 Remote AutoComplete 使用的取資料的方式
           3. StoreDomId                     - 選取下拉選單後會把 item.Id 放至 StoreDomId 的 value 中
           4. AutoCompleteSuccessCallback(selectedItem)  - 選取下拉選單後會執行的 callback *@
    CustomAutoComplete.Register = function(obj){
        $("#" + obj.TriggerDomId).autocomplete({
            source: obj.Search,
            minLength: 1,
            select: function( event, selectTarget ) {
                console.log("id: " + selectTarget.item.id + " ,label: " + selectTarget.item.label + " ,value: " + selectTarget.item.value);

                $('#' + obj.StoreDomId).val(selectTarget.item.id);
                if (obj.AutoCompleteSuccessCallback)
                {
                    obj.AutoCompleteSuccessCallback(selectTarget.item);
                }
            }
        });

        $('#' + obj.StoreDomId).onchange = function(e){
            console.log(e);
        }
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
