# enum

```ts
export enum Action {
    Create = 'create',
    Update = 'update',
    Delete = 'delete'
}
```

## 另一種更好的替代方案 Union Type


```ts
type Action = 'create' | 'update' | 'delete';

const action : Action = 'create';

// 編譯失敗
// action = 'a';

console.log(action);

// vue
const action = Object as PropType<Action>;

```

