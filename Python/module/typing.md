# typeing

## Optional

-   可選參數
-   未給定參數時，以 None 給定 !

```python
from typing import Optional, Union

def test(a : Optional = None):
    if a is None:
        print("a is None")
        return

    print("a is not None", a)

test()
test(None)
test(1)
test('s')
```

也可以指定型別

> [T] 就像是 C# 的泛型 \<T> 一樣

```python
def test(a : Optional[int] = None):
```

指定型別後，test(‘s’) 就會出現警告，但仍然可以執行 !

## 指定多重型別

透過 Union[str, int] 就代表允許 string 或 int 型別

```python
def test(a : Optional[Union[str, int]] = None):
```
