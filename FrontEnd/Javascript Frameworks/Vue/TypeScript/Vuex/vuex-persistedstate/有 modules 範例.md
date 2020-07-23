# 有 modules 範例

要記得加上以下語法，才會確實保留狀態

```ts
preserveState: true
```

完整範例

```ts
import { Module, VuexModule, Mutation, Action, getModule } from 'vuex-module-decorators';
import store from "@/store";

@Module({
    store,
    namespaced: true,
    name: 'Auth',
    dynamic: true,
    preserveState: true,    
})
class Auth extends VuexModule {
    public token = '';

    @Mutation
    public SetToken(token: string) {
        this.token = token;
    }
}

export const AuthModule = getModule(Auth);

```

