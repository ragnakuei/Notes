# 呼叫 C++ 產生的 DLL

## 步驟

- 建立 C# 方案 及 專案
- 建立 C++ 專案

  範本選擇 `Windows Desktop Wizard`

  ![Text](./_images/Annotation&#32;2020-04-07&#32;084500.png)

  Aplicaiton Type 選擇 `Dynamic Link Library (dll)`

  Addition Options 勾選 `Empty Project` 

  ![Text](./_images/Annotation&#32;2020-04-07&#32;084501.png)

- 在 C++ 專案內建立 `Calculator Class`
  
  ![Text](./_images/Annotation&#32;2020-04-07&#32;084757.png)

  ![Text](./_images/Annotation&#32;2020-04-07&#32;084817.png)

  ![Text](./_images/Annotation&#32;2020-04-07&#32;084832.png)

  各檔案內容如下

  - [Calculator.h](https://github.com/ragnakuei/CallCplusplusFunction01/blob/master/CDoublePlus/Calculator.h)

  - [Calculator.cpp](https://github.com/ragnakuei/CallCplusplusFunction01/blob/master/CDoublePlus/Calculator.cpp)

- 建立 External Link   

  ![Text](./_images/Annotation&#32;2020-04-07&#32;084916.png)

  ![Text](./_images/Annotation&#32;2020-04-07&#32;084944.png)

  檔案內容如下

  - [ForExternCall.cpp](https://github.com/ragnakuei/CallCplusplusFunction01/blob/master/CDoublePlus/ForExternCall.cpp)

- 調整 C++ 專案內容

   C++ Project Properties > Configuration Properties > Advanced

   C++/CLI Properties > Common Language Runtime Support > 選擇 `Common Language Runtime Support(/clr)`

  ![Text](./_images/Annotation&#32;2020-04-07&#32;085107.png)

- 此時編譯 C++ 專案，還是會有錯誤

  ![Text](./_images/Annotation&#32;2020-04-07&#32;085150.png)

  C++ Project Properties > Configuration Properties > C/C++ > Language

  Comformance mode 改成 `No` 後，就可以編譯成功

  ![Text](./_images/Annotation&#32;2020-04-07&#32;085151.png)

- C# 專案呼叫 C++ DLL

  檔案內容如下

  - [Program.cs](https://github.com/ragnakuei/CallCplusplusFunction01/blob/master/CallCplusplusFunction01/Program.cs)

- 複製 C++ DLL 至 C# 專案中