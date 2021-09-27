# 帶上 parameter 的做法

- 只能給定 name，不可直接給定 path

#### 範例一

假設 router options 設定如下：

```js
{
    path: "/MeetingRoom", name: "MeetingRoom", component: MeetingRoom,
    children: [
        {
            path: '/MeetingRoom',
            name: 'MeetingRoomList',
            component: MeetingRoomList
        },
        {
            path: '/MeetingRoom/Add',
            name: 'MeetingRoomAdd',
            component: MeetingRoomAdd
        },
        {
            path: '/MeetingRoom/Edit/:guid',
            name: 'MeetingRoomEdit',
            component: MeetingRoomAdd
        },
    ]
},
```

則用以下面的語法，就可以轉到 `/MeetingRoom/Edit/:guid`

```ts
router.push({ name: 'MeetingRoomEdit', params: { guid: guid} });
```

在 template 中可以用下面語法取出 guid

```js
$route.params.guid
```

在 setup 中，用下面語法取出 guid

```ts
import { defineComponent, ref } from "vue";
import { useRoute } from "vue-router";

export default defineComponent({
  props : {},
  components : {},
  setup() {

      const route = useRoute();
      const guid = ref<string>(route.params.guid.toString());


      return {
          guid,
      };
  },
});
```