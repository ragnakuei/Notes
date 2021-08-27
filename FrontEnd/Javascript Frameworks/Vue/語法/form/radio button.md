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
                :value=1 >
        <label class="form-check-label"
                for="SchoolType.Custom">Option1</label>
    </div>
    <div class="form-check form-check-inline">
        <input class="form-check-input"
                type="radio"
                name="SchoolType"
                v-model="vModel.ViewModel.SchoolType"
                id="SchoolType.Custom"
                :value=2 >
        <label class="form-check-label"
                for="SchoolType.Custom">Option2</label>
    </div>
</div>
```

## value 要 binding 成 boolean

```html
<p>是否要檢查 Checksum</p>
<div class="form-check form-check-inline">
    <input class="form-check-input" type="radio" v-bind:name="[id]+'is_validate_checksum'" v-bind:id="[id]+'check_sum_yes'"
            v-bind:value="true" v-model="chunk_dto.IsValidateChecksum">
    <label class="form-check-label" v-bind:for="[id]+'check_sum_yes'">是</label>
</div>
<div class="form-check form-check-inline">
    <input class="form-check-input" type="radio" v-bind:name="[id]+'is_validate_checksum'" v-bind:id="[id]+'check_sum_no'"
            v-bind:value="false" v-model="chunk_dto.IsValidateChecksum">
    <label class="form-check-label" v-bind:for="[id]+'check_sum_no'">否</label>
</div>

<div class="progress my-1"
        v-if="progress > 0 && progress < 100" >
    <div class="progress-bar"
        role="progressbar"
        v-bind:style="{ width : progress_bar_width }"
        ></div>
</div>
```