# sort 二個欄位

---

## property 確定都會有值的情況

```javascript
let students = [
  {
    firstName: "John",
    lastName: "Appletree",
    grade: 12,
    isFixed: true,
  },
  {
    firstName: "Mighty",
    lastName: "Peachtree",
    grade: 10,
    isFixed: false,
  },
  {
    firstName: "Kim",
    lastName: "Appletree",
    grade: 11,
    isFixed: true,
  },
  {
    firstName: "Shooter",
    lastName: "Appletree",
    grade: 12,
    isFixed: false,
  },
];

students.sort((a, b) => {
  // step 1 : isFixed
  let sortResult = SortIsFixed(a, b);
  if (sortResult !== 0) {
    return sortResult;
  }

  // step 2 : grade
  sortResult = SortGrade(a, b);
  return sortResult;
});

function SortIsFixed(a, b) {
  if (a.isFixed < b.isFixed) {
    return 1;
  } else if (a.isFixed > b.isFixed) {
    return -1;
  }

  return 0;
}

function SortGrade(a, b) {
  if (a.grade < b.grade) {
    return 1;
  } else if (a.grade > b.grade) {
    return -1;
  }

  return 0;
}
```

## property 不確定都會有值的情況

把 undefined 或 null 的值，放到最後面

```javascript
let students = [
  {
    firstName: "John",
    lastName: "Appletree",
    grade: 12,
    isFixed: true,
  },
  {
    firstName: "Mighty",
    lastName: "Peachtree",
    grade: 10,
    isFixed: false,
  },
  {
    firstName: "Kim",
    lastName: "Appletree",
    grade: 11,
    isFixed: true,
  },
  {
    firstName: "ShooterA",
    lastName: "Appletree",
    grade: null,
    isFixed: false,
  },
  {
    firstName: "ShooterB",
    lastName: "Appletree",
    grade: 12,
    isFixed: false,
  },
  {
    firstName: "ShooterC",
    lastName: "Appletree",
    grade: 12,
    isFixed: null,
  },
];

students.sort((a, b) => {
  // step 1 : isFixed
  let sortResult = SortIsFixed(a, b);
  if (sortResult !== 0) {
    return sortResult;
  }

  // step 2 : grade
  sortResult = SortGrade(a, b);
  return sortResult;
});

function SortIsFixed(a, b) {
  if (
    (a.isFixed == undefined || a.isFixed == null) &&
    (b.isFixed == undefined || b.isFixed == null)
  ) {
    // 不排序
    return 0;
  } else if (a.isFixed == undefined || a.isFixed == null) {
    return 1;
  } else if (b.isFixed == undefined || b.isFixed == null) {
    return -1;
  } else if (a.isFixed < b.isFixed) {
    return 1;
  } else if (a.isFixed > b.isFixed) {
    return -1;
  }

  return 0;
}

function SortGrade(a, b) {
  if (
    (a.grade == undefined || a.grade == null) &&
    (b.grade == undefined || b.grade == null)
  ) {
    // 不排序
    return 0;
  } else if (a.grade == undefined || a.grade == null) {
    return 1;
  } else if (b.grade == undefined || b.grade == null) {
    return -1;
  } else if (a.grade < b.grade) {
    return 1;
  } else if (a.grade > b.grade) {
    return -1;
  }

  return 0;
}
```