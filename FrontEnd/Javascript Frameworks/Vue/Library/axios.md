# axios

[Using Axios to Consume APIs](https://vuejs.org/v2/cookbook/using-axios-to-consume-apis.html)

## config

### withCredentials

-   會造成不會發 cors option 的動作

## 範例

```js
import axios from 'axios';
export default {
    data() {
        return {
            characters: [],
            loadingState: null,
        };
    },
    methods: {
        fetchCharacters() {
            this.loadingState = 'loading';
            axios
                .get('https://rickandmortyapi.com/api/character')
                .then((response) => {
                    this.loadingState = 'success';
                    this.characters = response.data.results;
                });
        },
    },
    created() {
        this.fetchCharacters();
    },
};
```

## 範例

```ts
import axios from 'axios';

export const HTTP = axios.create({
    baseURL: `http://jsonplaceholder.typicode.com/`,
    headers: {
        Authorization: 'Bearer {token}',
    },
});
```
