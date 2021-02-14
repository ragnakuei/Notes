# 範例 10 - ref & jQuery UI Dialog

- 與 [範例9](./範例%2009%20-%20emit%20&%20jQuery%20UI%20Dialog.md) 相同效果，但做法不同 !
- ref 放在 dom 上面，再 setup() 中宣告同名的 field，就可以達成 vue2 $refs 的效果 !
- 由 parent component 直接呼叫 child component 的 method !

```html
<div id="app" class="text-center" style="display: none">
  <button class="btn btn-dark" @@click="showDialogA">Toggle Dialog A</button>&nbsp
  <button class="btn btn-dark" @@click="showDialogB">Toggle Dialog B</button><br />
  <jquery-ui-dialog ref="dialogA" v-on:close_dialog="CloseDialogA">
    A
  </jquery-ui-dialog>
  <jquery-ui-dialog ref="dialogB" v-on:close_dialog="CloseDialogB">
    B
  </jquery-ui-dialog>
</div>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script src="https://unpkg.com/vue@next"></script>

<script>
  const { createApp, computed, onMounted, ref, watch } = Vue;

  const app = createApp({
    setup() {
      const dialogA = ref(null);
      const dialogB = ref(null);

      const showDialogA = function () {
        dialogA.value.showDialog();
      };

      const showDialogB = function () {
        dialogB.value.showDialog();
      };

      const CloseDialogA = function () {
        console.log("dialogA is closed");
      };

      const CloseDialogB = function () {
        console.log("dialogB is closed");
      };

      return {
        dialogA,
        dialogB,
        showDialogA,
        showDialogB,
        CloseDialogA,
        CloseDialogB,
      };
    },
  });

  app.component("jquery-ui-dialog", {
    setup(props, { emit }) {
      const dialogDom = ref(null);

      const showDialog = function () {
        dialogDom.value.dialog("open");
      };

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

      return {
        showDialog,
      };
    },
    template: `
<div id="dialog">
  <slot></slot>
</div>
`,
  });

  const vm = app.mount("#app");
  document.getElementById("app").style.display = "block";
</script>
```
