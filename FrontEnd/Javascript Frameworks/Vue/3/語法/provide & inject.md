# provide & inject


### global provide

```ts
import { computed, createApp, provide } from "vue";
import "./style.css";
import App from "./App.vue";
import router from "./router";
import { FetchService } from "./services/FetchService";

createApp(App)
    .use(router)
    .provide("FetchService", new FetchService())
    .mount("#app");
```