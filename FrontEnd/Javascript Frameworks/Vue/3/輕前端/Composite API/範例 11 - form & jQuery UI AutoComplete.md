# 範例 11 - form & jQuery UI AutoComplete

- 手動驗証

```html
<div id="app" class="text-center" style="display: none">
  <form-dto v-if="!dto" v-on:submit-form="submitForm"></form-dto>

  <dl v-if="dto" class="row">
    <dt v-if="dto.Id" class="col-sm-3 text-right">Id</dt>
    <dd v-if="dto.Id" class="col-sm-9 text-left">{{dto.Id}}</dd>

    <dt v-if="dto.Name" class="col-sm-3 text-right">Name</dt>
    <dd v-if="dto.Name" class="col-sm-9 text-left">{{dto.Name}}</dd>

    <dt v-if="dto.ProductId" class="col-sm-3 text-right">ProductId</dt>
    <dd v-if="dto.ProductId" class="col-sm-9 text-left">{{dto.ProductId}}</dd>
  </dl>
</div>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
  const { createApp, reactive, emit, ref, onMounted } = Vue;

  const app = createApp({
    setup() {
      const dto = ref(null);

      const submitForm = function (value) {
        console.log("submitForm", value);

        dto.value = value;
      };

      return {
        dto,
        submitForm,
      };
    },
  });

  app.component("form-dto", {
    setup(props, { emit }) {
      const dto = reactive({
        Id: null,
        Name: null,
        ProductId: null,
      });

      const validateErrors = ref({});

      // 在 AutoComplete 重新輸入
      const ResetProductInput = function (e) {
        dto.ProductId = null;
        dto.Product = e.data;
      };

      const submitForm = function () {
        
        // 手動驗証邏輯

        validateErrors.value = {};

        if (!dto.Id) {
          validateErrors.value.Id = "請輸入 Id";
        }

        if (!dto.Name) {
          validateErrors.value.Name = "請輸入 Name";
        }

        if (!dto.ProductId) {
          validateErrors.value.ProductId = "請輸入 Product";
        }

        if (!validateErrors.value.Id 
         && !validateErrors.value.Name
         && !validateErrors.value.ProductId) {
          emit("submit-form", dto);
          return;
        }

        console.log("validate errors:", validateErrors);
      };

      onMounted(() => {
        $("#Product").autocomplete({
          source: function (request, response) {
            $.ajax({
              url: "/api/Form/GetProducts",
              type: "post",
              data: JSON.stringify({ keyword: request.term }),
              dataType: "json",
              contentType: "application/json",
              success: response,
              error: function (e) {
                console.log(e);
              },
            });
          },
          minLength: 1,
          select: function (e, selectTarget) {
            dto.ProductId = selectTarget.item.id;
            dto.Product = selectTarget.item.label;
          },
        });
      });

      return {
        dto,
        validateErrors,
        submitForm,
        ResetProductInput,
      };
    },
    template: `
<form autocomplete="off"
      v-on:submit.prevent="submitForm">
  <div class="form-group row">
    <label class="col-sm-2 col-form-label text-right"
           for="Id">Id</label>
    <div class="col-sm-10 text-left">
        <input class="form-control"
               id="Id"
               v-model="dto.Id"
               placeholder="Enter Id" >
        <span v-if="validateErrors.Id"
              class="text-danger">
          {{validateErrors.Id}}
        </span>
    </div>
  </div>
  <div class="form-group row">
    <label class="col-sm-2 col-form-label text-right"
           for="Name">Name</label>
    <div class="col-sm-10 text-left">
        <input class="form-control"
               id="Name"
               v-model="dto.Name"
               placeholder="Enter Name" >
        <span v-if="validateErrors.Name"
              class="text-danger">
          {{validateErrors.Name}}
        </span>
    </div>
  </div>
  <div class="form-group row">
    <label class="col-sm-2 col-form-label text-right"
           for="ProductId">Product</label>
    <div class="col-sm-10 text-left">
        <input class="form-control"
               id="Product"
               v-model="dto.Product"
               v-on:input="ResetProductInput"
               placeholder="Enter Product" >
        <input type="hidden"
               class="form-control"
               id="ProductId"
               v-model="dto.ProductId" >
        <span v-if="validateErrors.ProductId"
              class="text-danger">
          {{validateErrors.ProductId}}
        </span>
    </div>
  </div>
  <button type="submit" class="btn btn-primary">Submit</button>
</form>
`,
  });

  const vm = app.mount("#app");
  document.getElementById("app").style.display = "block";
</script>

<style></style>
```