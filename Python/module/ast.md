# ast

可用來做為字串解析器

跟解析 json 還蠻像的

```python
from typing import Optional, Union

class Test:
    def __init__(self):
        print("Test class is created")

    def test(
            self,
            sides: Optional[Union[int, float, str]] = None,
    ):
        print("Test method is called")
        print("sides:", sides)

        import ast
        parsed_dict = ast.literal_eval(sides)

        a_side = parsed_dict['a_side']
        b_side = parsed_dict['b_side']
        c_side = parsed_dict['c_side']

        print("input sides:", a_side, b_side, c_side)


t = Test()
t.test("{'a_side': 3, 'b_side': 4, 'c_side': 5}")
```
