# 解析 excel

相關套件
- openpyxl
- langchain_community
- pandas
- xlrd
- networkx
- unstructured


### 方式 1 - 透過 langchain 使用 openpyxl

```python
from langchain_community.document_loaders import UnstructuredExcelLoader

def excelToStr(excel_path: str) -> str:
    loader = UnstructuredExcelLoader(excel_path, mode="elements")
    doc = loader.load()[0]
    return doc.page_content
```


### 方式 2 - 使用 openpyxl 解析成固定的資料結構

```python
from openpyxl import load_workbook, Workbook
from openpyxl.chartsheet import Chartsheet
from openpyxl.worksheet.worksheet import Worksheet

class Dto:
    def __init__(self, id: int, question: str, answer: str):
        self.id = id
        self.question = question
        self.answer = answer


def excelToDtos(excel_path: str) -> list[Dto]:
    dtos: list[Dto] = []
    wb: Workbook = load_workbook(filename=excel_path, read_only=True)
    sheet: Chartsheet | Worksheet = wb[wb.sheetnames[0]]
    for i, row in enumerate(sheet.iter_rows(values_only=True)):
        if i == 0:
            continue
        dto = Dto(i, row[0], row[1])
        dtos.append(dto)
    return dtos
```
