# sort 二個欄位

---

## property 確定都會有值的情況

```jsx
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

    // step 1 : isFixed
    if(a.isFixed < b.isFixed) { return 1; }
    else if(a.isFixed > b.isFixed) { return -1; }

    // step 2 : grade
    if(a.grade < b.grade) { return 1; }
    else if(a.grade > b.grade) { return -1; }

})
```

## property 不確定都會有值的情況

把 undefined 或 null 的值，放到最後面

```jsx
let students = [
  {
    firstName: "John",
    lastName: "Appletree",
    grade: 12,
    isFixed: true
  },
  {
    firstName: "Mighty",
    lastName: "Peachtree",
    grade: 10,
    isFixed: false
  },
  {
    firstName: "Kim",
    lastName: "Appletree",
    grade: 11,
    isFixed: true
  },
  {
    firstName: "Shooter",
    lastName: "Appletree",
    grade: null,
    isFixed: false
  },
  {
    firstName: "Shooter",
    lastName: "Appletree",
    grade: 12,
    isFixed: false
  },
  {
    firstName: "Shooter",
    lastName: "Appletree",
    grade: 12,
    isFixed: null
  }
];

students.sort((a, b) => {
  // step 1 : isFixed
  if ( (a.isFixed == undefined || a.isFixed == null)
    && (b.isFixed == undefined || b.isFixed == null)) { 
        // 不排序
  } 
  else if (a.isFixed == undefined || a.isFixed == null) { return 1; } 
  else if (b.isFixed == undefined || b.isFixed == null) { return -1; } 
  else if (a.isFixed < b.isFixed) { return 1; } 
  else if (a.isFixed > b.isFixed) { return -1; }

  // step 2 : grade
  if ( (a.grade == undefined || a.grade == null)
    && (b.grade == undefined || b.grade == null)) { 
        // 不排序
  } 
  else if (a.grade == undefined || a.grade == null) { return 1; } 
  else if (b.grade == undefined || b.grade == null) { return -1; } 
  else if (a.grade < b.grade) { return 1; } 
  else if (a.grade > b.grade) { return -1; }

  return 0;
});
```