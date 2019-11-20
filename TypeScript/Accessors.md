# [Accessors](https://www.typescriptlang.org/docs/handbook/classes.html#accessors)

Sample

```typescript
private _fullName: string;

get fullName(): string {
    return this._fullName;
}

set fullName(newName: string) {
    if (newName && newName.length > fullNameMaxLength) {
        throw new Error("fullName has a max length of " + fullNameMaxLength);
    }

    this._fullName = newName;
}
```
