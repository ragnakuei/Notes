# sort 二個欄位

```js
let students = [{
 firstName: 'John',
 lastName: 'Appletree',
 grade: 12,
 isFixed : true
},{
 firstName: 'Mighty',
 lastName: 'Peachtree',
 grade: 10,
 isFixed : false
},{
 firstName: 'Kim',
 lastName: 'Appletree',
 grade: 11,
 isFixed : true
},{
 firstName: 'Shooter',
 lastName: 'Appletree',
 grade: 12,
 isFixed : false
}];


students.sort((a,b) => {

    // step 1
    if(a.isFixed < b.isFixed) { return 1; }
    else if(a.isFixed > b.isFixed) { return -1; }

    // step 2
    if(a.grade < b.grade) { return 1; }
    else if(a.grade > b.grade) { return -1; }

})
```