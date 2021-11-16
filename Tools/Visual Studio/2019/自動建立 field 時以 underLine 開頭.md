# 自動建立 field 時以 underLine 開頭

https://stackoverflow.com/questions/45736659/how-do-i-customize-visual-studios-private-field-generation-shortcut-for-constru

1. Tools -> Options -> Text Editor -> C# -> Code Style -> Naming

1. 新增 Naming Style
   1. 輸入 Title，例：**Begins with _**
   2. Required Prefix 輸入 **_**
   3. Captialization 選擇 **camel Case Name**

1. 新增 Rule
   1. Specification 選擇 **Private Or Internal Field**
   2. Required Style 選擇剛才建立的 Nameing Style，例：**Begins with _**
   3. Serverity 依照需求選擇即可 !

2. 完成
