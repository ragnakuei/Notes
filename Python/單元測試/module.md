# module

## 標準 module

-   unittest
-   doctest

## 第三方 module

-   nose
-   pytest

## unittest

執行指定單元測試

> python -m unittest -v tests.test_calculator

-   -m : 指定模組名稱
    -   unittest : 模組名稱
    -   tests.test_calculator : 測試檔案名稱

## doctest

## nose

在 python 3.12 因移除 imp module，所以 nose 會無法使用