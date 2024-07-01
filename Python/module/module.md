# module

## 載入

基本上分為二種

-   直接被 python cli 執行
-   被 module 引用的方式執行

當該 .py 檔案同時被這二個方式設計時，會因為 1 項的初始化，而影響了 2 項的使用方式

可以用下面的方式，來避免互相干擾

```python
if __name__ == "__main__":
    # 這邊只做 1 項的初始化
```

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
