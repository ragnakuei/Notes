# Auto Complete

因為顯示出來的資料，放在 input 中，只能有一個值
所以在選取對應的項目後，可以把 value 放到 input type hidden 中，方便在 submit form 時，可以正確回應 value 給後端

1. 範例

    ```html
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
    var searchEmployeeApiUrl = '@(Url.Action("SearchEmployee", "Leave"))';
    var searchEmployeeResultTextDomObjectId = 'Employee';
    var searchEmployeeResultValueDomObjectId = '@(nameof(Model.EmployeeId))';

    var searchResult = [];

        $(document).ready(function () {
            $('#' + searchEmployeeResultTextDomObjectId).autocomplete({
                // source 可直接指定 api url，但是為求彈性轉換，所以改用手動以 ajax 的方式取得資料後，再轉成 autocomplete 需要的物件格式
                source: function (request, response) {
                                    $.ajax({
                                        url: searchEmployeeApiUrl,
                                        type: 'post',
                                        data: JSON.stringify(request.term),
                                        dataType: 'json',
                                        contentType: 'application/json',
                                        success :  function(data)
                                        {
                                            searchResult = data;

                                            response($.map(data, function (item)
                                                                {
                                                                    return {
                                                                        label : item.name,
                                                                        value : item.id
                                                                    };
                                                                }));
                                        },
                                        error: function () {
                                            response([]);
                                        }
                                    })
                                },
                // 輸入停止後 1 秒才進行取資料的動作
                delay: 1000,

                // 取資料成功後執行的地方，如果 return false 的話，就不會執行下個步驟
                search: function( event, ui ) {
                                // console.log('search');
                                // return false;
                            },
                // 取得資料後，顯示下拉選單的動作
                open: function( event, ui ) {
                                // console.log('open');
                                // return false;
                            },
                // 點擊下拉選單的其中一個項目後的動作
                select: function (event, ui) {
                    $('#' + searchEmployeeResultValueDomObjectId).val(ui.item.value);
                }
            });
        });
    </script>

    <input class="form-control"
                    data-val="true"
                    data-val-required="The Employee field is required."
                    type="text"
                    id="Employee" />
    <input class="form-control"
            type="hidden"
            asp-for="EmployeeId" />
    ```

[參考資料](https://dotblogs.com.tw/a802216/2013/09/19/119070)
