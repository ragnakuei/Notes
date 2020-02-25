# python

- [python](#python)
  - [web framework](#web-framework)
  - [Windows 10](#windows-10)
  - [安裝 pip 至 Windows 中](#%e5%ae%89%e8%a3%9d-pip-%e8%87%b3-windows-%e4%b8%ad)
  - [安裝 pylint](#%e5%ae%89%e8%a3%9d-pylint)
  - [編譯成 pyc 檔](#%e7%b7%a8%e8%ad%af%e6%88%90-pyc-%e6%aa%94)

---

https://docs.python.org/3.8/tutorial/index.html

https://code.visualstudio.com/docs/python/python-tutorial

https://code.visualstudio.com/docs/editor/intellisense#_customizing-intellisense

- [跟著微軟一起學 Python](https://blog.darkthread.net/blog/-python-for-beginners/)

## web framework

- Django
- Flask
- Pyramid
- web2py
- bottle.py
- Zope & Plone

## Windows 10

在 cmd 內，輸入並執行 `python` 後，會開啟 Microsoft Store

只要刪除環境變數 Path 的 `%USERPROFILE%\AppData\Local\Microsoft\WindowsApps`

就可以了

## 安裝 pip 至 Windows 中

1. 至[這邊](https://bootstrap.pypa.io/get-pip.py)下載 pip python install script
1. 以 python 來執行剛才的 install script
1. 在 cmd 下，直接輸入 pip ，確認安裝完畢

## 安裝 pylint

- pip install pylint

> 註：pip 應該是在裝完 python 時就一併安裝了

## 編譯成 pyc 檔

import 的檔案只會辨識 pyc 檔

如果要製作 module 檔，可以先編譯成 pyc 檔

> python -m compileall `pythonFile.py`