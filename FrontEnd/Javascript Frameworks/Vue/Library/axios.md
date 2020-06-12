# axios

[Using Axios to Consume APIs](https://vuejs.org/v2/cookbook/using-axios-to-consume-apis.html)

## 範例

```js
import axios from 'axios'
export default {
  data () {
    return {
      characters: [],
      loadingState: null,
    }
  },
  methods: {
    fetchCharacters () {
      this.loadingState = 'loading'
      axios.get('https://rickandmortyapi.com/api/character')
        .then(response => {
          this.loadingState = 'success'
          this.characters = response.data.results
      	})
    }
  },
  created () {
    this.fetchCharacters()
  }
}
```