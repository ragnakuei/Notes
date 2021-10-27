# [ajax](https://rxjs.dev/api/ajax/ajax)

```js
import { ajax } from 'rxjs/ajax';

const githubUsers = `https://jsonplaceholder.typicode.com/users`;

const users = ajax.getJSON(githubUsers);

const subscribe = users.subscribe(
    (res) => console.log(res),
    (err) => console.error(err),
);
```

```js
import { ajax } from 'rxjs/ajax';

const githubUsers = `https://jsonplaceholder.typicode.com/users`;

const users = ajax.getJSON(githubUsers);

const subscribe = users.pipe(
  map(response => console.log(res)),
  catchError(error => {
    console.error(err);
    return of(error);
  })
);
```

```js
import { ajax } from 'rxjs/ajax';

const githubUsers = `https://jsonplaceholder.typicode.com/users`;

const users = ajax({
    url: githubUsers,
    method: 'GET',
    headers: {
        /*some headers*/
    },
    body: {
        /*in case you need a body*/
    },
});

const subscribe = users.subscribe(
    (res) => console.log(res),
    (err) => console.error(err),
);
```
