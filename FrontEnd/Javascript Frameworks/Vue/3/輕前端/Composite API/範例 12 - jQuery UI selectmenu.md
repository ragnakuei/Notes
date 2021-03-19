# 範例 12 - jQuery UI selectmenu
 
- 預設的 option 可以設定 value = null，來讓 v-model 的值為 null 時，可以停在預設的 option 上

```html
@model SelectMenuViewModel
<div id="app"
     class="text-center"
     style="display: none">
    <form v-on:submit.prevent="submitForm">
        <label for="GendorId">性別：</label>
        <select id="GendorId" v-model="model.GendorId">
            <option value=null disabled selected>請選擇</option>
            <option v-for="gendor in gendorOptions" :value="gendor.Value">{{gendor.Text}}</option>
        </select><br>

       <input type="submit" value="送出" />
    </form>

</div>

@section Scripts
{
    <script src="https://unpkg.com/vue@next"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script>
      const gendors = @Html.Raw(ViewBag.GendorOptionsJson?.ToString());
      const sumbitUrl = '@Url.Action("PostStyle1")';
      const redirectUrl = '@Url.Action("Style1Result")';

      const { createApp, reactive, emit, ref, onMounted } = Vue;

      const app = createApp({
        setup(){

          const gendorOptions = gendors;

          const model = reactive({
            GendorId : null
          });

          onMounted(() => {
              $('select').selectmenu({
                // 一旦使用 jQuery UI selectmenu 就必須要加上 change event 來做回寫的動作
                change : (e, item) => {
                   console.log('select change',item);
                   model.GendorId = item.item.value;
                },
                open: (e) => {
                    // 頁面上同時有多個 select menu 時，讓非觸發的 select menu 可以被關閉
                    const target = e.target;

                    $('select').each((index, item) => {
                        if (item !== target) {
                            $(item).selectmenu("close");
                        }
                    })
                },
              });
          });

          function submitForm () {
            $.ajax({
                      url: sumbitUrl,
                      type: 'post',
                      data: JSON.stringify( model ),
                      dataType: 'json',
                      contentType: 'application/json',
                  })
             .done(function(res) {
                      console.log('done', res);
                      window.location.href = redirectUrl;
                  })
             .fail(function(res) {
                      console.log('error', res);
                  });
          }

          return {
            gendorOptions,
            model,
            submitForm
          }
        },
      });

      const vm = app.mount('#app');
      window.addEventListener('DOMContentLoaded', (event) => {
        document.getElementById("app").style.display = "block";
      });
    </script>

    <style>

  </style>
}
```