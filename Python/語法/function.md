# fuction

## 宣告 method ，並給定參數預設值

```python
def add(a=0,b=0):
  return a+b;

print(add(1,2))
print(add(a=1,b=2))
print(add(b=2,a=1))
```

另一種寫法：[Optional](../module/typing.md#Optional)

## 引數為 **args 的宣告

```python
def test(**args):
  print(args['a'])

test(a=1)
```

## 參數

```python
def functionName(a):
    # function content
    return
```

宣告 functionName 的 function，必須給定一個參數 a



