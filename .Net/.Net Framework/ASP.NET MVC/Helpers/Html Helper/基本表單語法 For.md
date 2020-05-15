# 基本表單語法 For


就是強型別的輔助方式

例如，原本是Html.TextBox會變成Html.TextBoxFor

一定會在View的頁面最上方用@model定義出型別

除了基本表單語法中的項目+For變成強型別外，一定會用Lambda Expression

還有以下很重要的

| Html Helper                            | 說明                                                |
| --------------------------- | ----------------------------------------------- |
| Html.DisplayNameFor()       | 顯示該欄位在metadata定義的顯示名稱(DisplayName) |
| Html.DisplayTextFor()       | 顯示該欄位內的資料                              |
| Html.ValidationMessageFor() | 顯示驗証失敗所要顯示的提示訊息                  |

關聯：

**Html.DisplayNameFor**、**Html.DisplayFor** 為 **templated helper**