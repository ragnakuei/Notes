# object

## 建立 object 的方式

### object literal

```js
var person = {
    firstName: 'Peter',
    lastName: 'Jobs',
    age: 25,
};
```

### object using constructor

```js
function Person(firstName, lastName, age) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.age = age;
}

let p = new Person('Peter', 'Jobs', 25);
```

### object create method

```
let person = {
    firstName: "Peter",
    lastName: "Jobs",
    fullName: function() {
        return this.firstName + ' ' + this.lastName;
    }
}

let newPerson = Object.create(person);
newPerson.firstName = 'Mary';
newPerson.lastName = 'Smith';
```
