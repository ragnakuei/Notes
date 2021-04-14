# row

## 同一個 row 內的二個 button，一個靠左，一個靠右

- 整列給定 .row 來包住二個 button
- 左邊 div 給定 .col-auto mr-auto
- 右邊 div 給定 .col-auto

```html
<div class="row">
    <!-- 靠左 -->
    <div class="col-auto mr-auto">
        <button type="button"
                class="btn btn-primary"
                v-on:click="AddDetail()">
            Add Detail
        </button>
    </div>
    <!-- 靠右 -->
    <div class="col-auto">
        <button type="button"
                class="btn btn-primary">
            Calculate
        </button>
    </div>
</div>
```

## row 內靠物件靠右的方式

- 整列給定 .row 來包住二個 button
- 左邊 div .col-auto mr-auto，無 inner html
- 右邊 button 給定 .col-auto

```html
<div class="row my-1">
    <div class="col-auto mr-auto"></div>
    <div class="col-auto">
        <button type="button"
                class="btn btn-primary float-right">
            Submit
        </button>
    </div>
</div>
```