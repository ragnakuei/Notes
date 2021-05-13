# slot

[[Vue] Slot 是什麼? 怎麼用?](https://medium.com/itsems-frontend/vue-slot-21e1ec9968f8)

- 不要用 slot attribute 語法
- 不要用 slot-scope 語法


## 範例

- slot name 為 page_no_text

呼叫端

```html
    <pagination-link v-bind:is_enable="page_info.PageNo > 1"
                     v-bind:page_no=1
                     v-on:click_link=to_page(1)>
        <template v-slot:page_no_text>第一頁</template>
    </pagination-link>
```

被呼叫端

```js
window.PaginationLink = {
    template: `
      <a v-if="is_enable"
         v-on:click="click_link(page_no)"
         class="page-link"
         href="javascript:;">
        <slot name="page_no_text"></slot>
      </a>
      <a v-else
         class="page-link">
         <slot name="page_no_text"></slot>
      </a>
    `,
    props: {
        is_enable : Boolean,
        page_no : Number,
    },
    setup(props, { emit }) {

        const click_link = function (page) {
            emit('click_link', page);
        }

        return {
            click_link,
        };
    }
}
```

