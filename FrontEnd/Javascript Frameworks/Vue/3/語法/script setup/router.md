# router

```js
import { useRouter, useRoute } from "vue-router";
import store from "../store";
import UserEventsService from "../services/UserEventsService";

const router = useRouter();
const route = useRoute();

const userEvents = ref( [] );
const selectedEvent = ref( null );

const userId = ref(route.params.userid.toString());

onMounted( () => {
    if( !userId.value ) {
        router.push( "/Users" );
    }

    UserEventsService.getAll( userId.value ).then(
        ( response ) => (userEvents.value = response)
    );
} );
```