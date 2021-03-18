# css selector

[金魚都能懂的 CSS 選取器 - 金魚都能懂了你還怕學不會嗎 系列](https://ithelp.ithome.com.tw/users/20112550/ironman/2799?sc=iThelpR)

## >

`>` 的每一個階層，都必須是剛好符合對應的結構

### 範例一

```css
#editForm > p > #id;
```

就可以指向下方 #id 的 dom

```html
<form id="newForm" class="editForm">
    <p>
        <label for="id">id:</label>
        <input type="text" id="id" />
    </p>
</form>
```

## 模糊式指定

以空白字元間隔，則為視為不指定中間結構

```css
#editForm #id;
```

則在 `#editForm` 尋找符合 `#id` 的 dom

但相對來說，尋找速度會比明確的指定來的慢 !

### 範例一

```css
#editForm #id;
```

就可以指向下方 #id 的 dom

```html
<form id="newForm" class="editForm">
    <p>
        <label for="id">id:</label>
        <input type="text" id="id" />
    </p>
</form>
```

```html
<form id="editForm" class="editForm">
    <p>
        <p>
            <p>
                <label for="id">id:</label>
                <input type="text" id="id">
            </p>
        </p>
    </p>
    <p>
    <label for="name">name:</label>
    <input type="text" id="id">
    </p>

    <p>
    <input type="button" id="editFormSubmit"  value="submit"/>
    </p>
</form>
```
