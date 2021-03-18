# module

## 基本語法

calculator.py

```python
def add(i1, i2):
    return i1+i2
```


run.py

```python
import calculator

result = calculator.add(1,2)
print(result)
```

執行
> python run.py

實際上會產生 `calculator.pyc` 這個檔案才是 import 的來源