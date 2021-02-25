# radio button

## value 要 binding 成數字

將原本輸入的 `value=2` 改為 `:value=2` 就可以了

```html
<div class="form-group form-inline ml-3">
    <div class="form-check form-check-inline">
        <input class="form-check-input"
                type="radio"
                name="SchoolType"
                v-model="vModel.ViewModel.SchoolType"
                id="SchoolType.Custom"
                :value=2
                v-on:blur="onBlur($event)">
        <label class="form-check-label"
                for="SchoolType.Custom">自訂</label>
    </div>
    <div class="form-group">
        <input type="password" class="form-control" id="inputPassword4" placeholder="Password">
    </div>
</div>
``