# [MiniExcel](https://github.com/MiniExcel/MiniExcel)

-   讀取
    -   會自動解析第一列為 Column Name

套用範本

-   https://github.com/mini-software/MiniExcel?tab=readme-ov-file#fill-data-to-excel-template-

### [Grouped Data Fill](https://github.com/mini-software/MiniExcel?tab=readme-ov-file#7-grouped-data-fill)

1. group 要以 @group 及 @endgroup 來定義好範圍
1. 接下來依照各種情境，分為

    - 有 @header

        後方所指定的 column 就可以視為 groupby 之欄位
        可以省去將資料做 groupby

    - 沒有 @header

        沒有 @header
        等於以 loop 方式來顯示資料
