# deep.equal

```js
let expect = require("chai").expect;

it("object equals", () => {
  let actual = {
    name: "A",
  };

  let expected = {
    name: "A",
  };

  expect(actual).to.deep.equal(expected);
});
```