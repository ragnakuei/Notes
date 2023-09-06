# 範例 09 - emit & jQuery UI Dialog

- 運用 slot 來重覆使用 component
- 運用 watch props 來判斷是否需要開啟 jQuery UI Dialog
- setup() 的 emit 參數給定，必須放在 props 後面的物件中

```html
<div id="app" class="text-center" style="display: none">
  <button @@click="showDialogA">Toggle Dialog A</button>&nbsp
  <button @@click="showDialogB">Toggle Dialog B</button><br />
  <jquery-ui-dialog
    v-model:is_show="isShowDialogA"
    v-on:close_dialog="CloseDialogA"
  >
    A
  </jquery-ui-dialog>
  <jquery-ui-dialog
    v-model:is_show="isShowDialogB"
    v-on:close_dialog="CloseDialogB"
  >
    B
  </jquery-ui-dialog>
</div>

<link
  rel="stylesheet"
  href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"
/>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script src="https://unpkg.com/vue@next"></script>

<script>
  const { createApp, computed, onMounted, ref, watch } = Vue;

  const app = createApp({
    setup() {
      const isShowDialogA = ref(false);
      const isShowDialogB = ref(false);

      const showDialogA = function () {
        isShowDialogA.value = true;
      };

      const showDialogB = function () {
        isShowDialogB.value = true;
      };

      const CloseDialogA = function () {
        isShowDialogA.value = false;
      };

      const CloseDialogB = function () {
        isShowDialogB.value = false;
      };

      return {
        isShowDialogA,
        isShowDialogB,
        showDialogA,
        showDialogB,
        CloseDialogA,
        CloseDialogB,
      };
    },
  });

  app.component("jquery-ui-dialog", {
    props: {
      is_show: null,
    },
    setup(props, { emit }) {
      const dialogDom = ref(null);

      onMounted(() => {
        dialogDom.value = $("#dialog").dialog({
          autoOpen: false,
          width: "auto",
          modal: true,
          close: function (event, ui) {
            emit("close_dialog");
          },
        });
      });

      watch(
        () => props.is_show,
        (newValue, oldValue) => {
          console.log("watch is_show", props.is_show);

          if (newValue === true) {
            dialogDom.value.dialog("open");
          }
        }
      );

      return {};
    },
    template: `
<div id="dialog">
  <slot></slot>
</div>
`,
  });

  const vm = app.mount("#app");
  window.addEventListener('DOMContentLoaded', (event) => {
    document.getElementById("app").style.display = "block";
  });
</script>

```
