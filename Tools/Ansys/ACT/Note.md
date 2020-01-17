# Note

- [Note](#note)
  - [增加 Button 的語法](#%e5%a2%9e%e5%8a%a0-button-%e7%9a%84%e8%aa%9e%e6%b3%95)
  - [指定專案為 WorkBench 的方式](#%e6%8c%87%e5%ae%9a%e5%b0%88%e6%a1%88%e7%82%ba-workbench-%e7%9a%84%e6%96%b9%e5%bc%8f)
  - [指定要參考的 python 檔](#%e6%8c%87%e5%ae%9a%e8%a6%81%e5%8f%83%e8%80%83%e7%9a%84-python-%e6%aa%94)

---

## 


---

## 增加 Button 的語法

在根目錄的 xml 中

```xml
<interface context="DesignModeler">
    <images>images</images>
    <toolbar name="Deck" caption="Deck">
        <entry name="Deck" icon="deck">
            <callbacks>
                <onclick>CreateDeck</onclick>
            </callbacks>
        </entry>
        <entry name="Support" icon="Support">
            <callbacks>
                <onclick>CreateSupport</onclick>
            </callbacks>
        </entry>
    </toolbar>
</interface>
```

在 onclick 所指定的字串

- 會對應到 同主檔名資料夾內的 python 檔中的 method
- method 引數給定 ag (尚不確定用法)

  一般而言，用以下語法來執行 Feature

  ```python
  ExtAPI.CreateFeature("Deck")
  ```

  完成語法如下:

  ```python
  def CreateDeck(ag):
    """
        When clicking on Deck button
    """
    ExtAPI.CreateFeature("Deck")
  ```

---

## 指定專案為 WorkBench 的方式

```txt
context="Project"
```

---

## 指定要參考的 python 檔

python 要放在與 xml 主檔名相同的資料夾內

```txt
<script src="IDEGeneratedMain.py" />
```
