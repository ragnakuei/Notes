# Specification Pattern

[thiagodp/spec-pattern](https://github.com/thiagodp/spec-pattern)

```jsx
import { Between, In, GreaterThan } from 'spec-pattern';

let rules = new Between( 1, 3 )
   .or( new Between( 6, 9 ) )
   .or( new In( [ 11, 25, 31 ] ) )
   .or( new GreaterThan( 50 ) );

console.log( rules.isSatisfiedBy( 2 ) ); // true
console.log( rules.isSatisfiedBy( 7 ) ); // true
console.log( rules.isSatisfiedBy( 5 ) ); // false
console.log( rules.isSatisfiedBy( 11 ) ); // true
console.log( rules.isSatisfiedBy( 50 ) ); // false
console.log( rules.isSatisfiedBy( 51 ) ); // true

// Printable !
console.log( rules.toString() );
// (((between (1, 3) or between (6, 9)) or in [11, 25, 31]) or greater than 50)
```

很像 C# 的 Expression Tree 做法 !