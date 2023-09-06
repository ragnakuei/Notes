# 前端處理字串、後端處理 NullableDecimal

- [專案連結-簡單](https://github.com/ragnakuei/JsonDecimalFloat)
- [專案連結-完整](https://github.com/ragnakuei/DecimalFloatTailZero)
- 搭配輕前端 vue 3

## 後端

### 新增 JsonConverter - 將 json 內的字串轉成 decimal?

```csharp
public class StringNullableDecimalJsonConverter : JsonConverter<decimal?>
{
    public override decimal? Read(ref Utf8JsonReader    reader,
                                    Type                  typeToConvert,
                                    JsonSerializerOptions options)
    {
        if (Decimal.TryParse(reader.GetString(), out var result))
        {
            return result;
        }

        return null;
    }

    public override void Write(Utf8JsonWriter        writer,
                                decimal?              nullableDecimal,
                                JsonSerializerOptions options) =>
        writer.WriteStringValue(nullableDecimal.ToString());
}
```

### 將 JsonConverter 以 Attribute 的方式指定要套用這種轉換的 Property ，避免全域共用

```csharp
public class HomeController : Controller
{
    [HttpGet]
    public IActionResult Index()
    {
        return View();
    }

    [HttpPost, Route("api/[Controller]")]
    public IActionResult Post([FromBody]TestViewModel vm)
    {
        vm.Dto.MeasureValue *= 1.0m;

        return Ok(vm);
    }
}

public class TestViewModel
{
    public TestDto Dto { get; set; }
}

public class TestDto
{
    // 指定 JsonConverter 要套用的 Property
    [JsonConverter(typeof(StringNullableDecimalJsonConverter))]
    public decimal? MeasureValue { get; set; }
}
```

## 前端

- 前端視該 Property 為字串，所以 v-model 不加上 .number 來將值轉為 number !
- 為避免不必要的處理，將 input type 指定為 number

```html
@{
    Layout = null;
}

<div id="app"
     style="display: none">
    <form autocomplete="off"
          class="text-center"
          v-on:submit.prevent="Submit()">
        <label>{{vm.Dto.MeasureValue}}</label>
        <br>

        <!-- 為避免不必要的處理，將 input type 指定為 number -->
        <input type="number" v-model="vm.Dto.MeasureValue" />

        <input type="submit"
               value="Submit" />
    </form>
</div>

<script src="/lib/jquery/jquery-1.12.4.js"
            asp-append-version="true"></script>

<partial name="_CustomRequest"/>

<script src="/lib/vue/vue.global.prod.js"></script>
<script>
  const { createApp, ref, reactive, onMounted, computed } = Vue;

  const app = createApp({
    setup(){

      const submitUrl = '@(Url.Action("Post"))';

      const vm = reactive({
            Dto : {
                MeasureValue : '1.0',
            }
      });

       const customRequest = {};
       customRequest.Url = submitUrl;
       customRequest.RequestBody = vm;
       customRequest.SuccessCallback = function(e)
       {
           console.log(e);

           vm.Dto = e.Dto;
       };
       customRequest.Request = new CustomRequest(customRequest);

      const Submit = function()
      {
          customRequest.Request.PostJson();
      }

      return {
        vm,
        Submit
      }
    }
  });

  const vm = app.mount('#app');

  window.addEventListener('DOMContentLoaded', (event) => {
    document.getElementById("app").style.display = "block";
  });

</script>
```