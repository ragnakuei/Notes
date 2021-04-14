# [form inline](https://getbootstrap.com/docs/4.0/components/forms/#inline-forms)


- .form-inline 將 一堆 label / form controls / buttons 放在單一 row 上

```html
<div class="form-group form-inline">
    <label for="Name"
            class="control-label">
        Name
    </label>
    <input id="Name"
            v-model="vm.Name"
            class="form-control mx-3" />
</div>
```