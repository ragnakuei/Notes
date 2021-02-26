# disabled binding 方式

> :disabled="判斷條件"

```html
<div class="form-group">
    <select class="form-control"
            v-model="vModel.ViewModel.SchoolOptionGuid"
            name="SchoolType"
            v-on:blur="onBlur($event)"
            :disabled="vModel.ViewModel.SchoolType !== 1">
        <option>請選擇</option>
        <option v-for="school in schoolOptions"
                :value="school.Value">
            {{school.Text}}
        </option>
    </select>
</div>
```