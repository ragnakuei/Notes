# Sample01

#### Tests

```js
pm.test("Status code is 200", () => {
  const body = pm.response.json();
  pm.expect(body).to.eql(3);
});
```
