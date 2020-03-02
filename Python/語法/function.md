# fuction

## 宣告 method ，並給定參數預設值

```python
def add(a=0,b=0):
  return a+b;

print(add(1,2))
print(add(a=1,b=2))
print(add(b=2,a=1))
```

## 引數為 **args 的宣告

```python
def test(**args):
  print(args['a'])

test(a=1)
```