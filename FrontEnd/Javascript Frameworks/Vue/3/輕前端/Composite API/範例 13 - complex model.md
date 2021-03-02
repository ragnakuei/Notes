# 範例 13 - complex model

Controller

```csharp
[HttpGet]
public IActionResult Style3()
{
    ViewBag.EmptyCategoryJson = new Category
                            {
                                Items = Enumerable.Range(0, 3)
                                                    .Select(i => new Item())
                                                    .ToArray(),
                            }.ToJson();


    return View(_vm);
}

[HttpPost]
public IActionResult PostStyle3([FromBody]ComplexViewModel vm)
{
    _contextAccessor.HttpContext.Session.SetString(_style3ViewModelKey, vm.ToJson());

    return Ok(vm);
}

[HttpGet]
public IActionResult ShowStyle3()
{
    var vmJson = _contextAccessor.HttpContext.Session.GetString(_style3ViewModelKey);

    var vm = vmJson.ParseJson<ComplexViewModel>();

    ViewBag.ReturnUrl = Url.Action("Style3");

    return View("ComplexViewModel", vm);
}
```

Model

```csharp
public class ComplexViewModel
{
    public Category[] Categories { get; set; }
}

public class Category
{
    public int? Id { get; set; }

    public string Name { get; set; }

    public Item[] Items { get; set; }
}

public class Item
{
    public int? Id { get; set; }

    public string Name { get; set; }

    public decimal? Value { get; set; }
}
```

View

```html
@model AspNetCoreMvcWithLightVue.Controllers.ComplexViewModel

<h4>ComplexViewModel 輕前端 Vue 版</h4>
<hr />
<div id="app"
     style="display: none">
    <input type="button"
           value="新增"
           class="btn btn-primary"
           style="margin: 5px;"
           v-on:click="AddNewCategory()" />
    <form autocomplete="off"
          v-on:submit.prevent="SubmitForm">
        <div id="categories">
            <table class="table"
                   v-for="(category, categoryIndex) in vm.Categories"
                   :key="categoryIndex">
                <thead>
                <tr>
                    <th>Category</th>
                    <th>Name</th>
                    <th>Value</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="(item, itemIndex) in category.Items"
                    :key="itemIndex">
                    <td v-if="itemIndex == 0"
                        class="align-middle"
                        rowspan="3">
                        <input class="form-control"
                               v-model="category.Name" />
                    </td>

                    <td>
                        <input class="form-control"
                               v-model="item.Name" />
                    </td>
                    <td>
                        <input class="form-control"
                               v-model="item.Value" />
                    </td>

                    <td v-if="itemIndex == 0"
                        class="align-middle"
                        rowspan="3">
                        <input type="button"
                               class="btn btn-danger"
                               value="刪除"
                               v-on:click="DeleteItem(categoryIndex)" />
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="form-group">
            <input type="submit"
                   value="儲存"
                   class="btn btn-primary" />
        </div>
    </form>
</div>

<a href='@Url.Action("Index")'>回上一頁</a>

@section Scripts
{
    <script src="https://unpkg.com/vue@next"></script>

    <script>
      const { createApp, reactive } = Vue;

      const app = createApp({

          setup() {
              const vm = reactive( @Html.Raw(Model?.ToJson()) );
              const submitUrl = '@Url.Action("PostStyle3")';
              const redirectUrl = '@Url.Action("ShowStyle3")';
              const emptyCategory = @Html.Raw(ViewBag.EmptyCategoryJson);

              function AddNewCategory() {
                  vm.Categories.push(emptyCategory);
              }

              function DeleteItem(categoryIndex) {
                  vm.Categories.splice(categoryIndex, 1);
              }

              function SubmitForm () {
                  console.log("SubmitForm");

                  $.ajax({
                              url: submitUrl,
                              type: 'post',
                              data: JSON.stringify( vm ),
                              dataType: 'json',
                              contentType: 'application/json',
                         })
                     .done((e) => { window.location.href = redirectUrl })
                     .fail((res) => { console.log('error', res); })
              }

              return {
                vm,
                AddNewCategory,
                DeleteItem,
                SubmitForm,
              };
          },
      });

      const vm = app.mount("#app");
      window.addEventListener('DOMContentLoaded', (event) => {
        document.getElementById("app").style.display = "block";
      });
    </script>
}
```
