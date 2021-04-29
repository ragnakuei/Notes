# number list 重新給定編號的方式

-   將 37~39 段落，複製至 40~42，並重新給定 number list 編號

    -   38~39 行是 number list

    ```csharp

    if (doc.ChildNodes[1] is not Section section
        || section.ChildNodes[2] is not Body body
        || body.ChildNodes[36] is not Table table
        )
    {
        return;
    }

    // 複製指定的段落
    var tableCommentParagraphs = new Paragraph[]
                                    {
                                        body.ChildNodes[37].Clone(true) as Paragraph,
                                        body.ChildNodes[38].Clone(true) as Paragraph,
                                        body.ChildNodes[39].Clone(true) as Paragraph,
                                    };

    // 37 複製至 40
    body.ChildNodes.Insert(40, tableCommentParagraphs[0].Clone(true));

    // 38 複製至 41
    body.ChildNodes.Insert(41, tableCommentParagraphs[1].Clone(true));

    // 39 複製至 42
    body.ChildNodes.Insert(42, tableCommentParagraphs[2].Clone(true));

    // 38 是 number 第一個項目，將其 list 項目複製出來，會在 doc.Lists 中產生新的 List
    var newList = doc.Lists.AddCopy((body.ChildNodes[38] as Paragraph).ListFormat.List);

    // 將新的 list 套用至 41、42 的段落上
    (body.ChildNodes[41] as Paragraph).ListFormat.List            = newList;

    // LeftIndent 可能會跑掉，所以重新給定
    (body.ChildNodes[41] as Paragraph).ParagraphFormat.LeftIndent = (body.ChildNodes[38] as Paragraph).ParagraphFormat.LeftIndent;

    (body.ChildNodes[42] as Paragraph).ListFormat.List            = newList;
    (body.ChildNodes[42] as Paragraph).ParagraphFormat.LeftIndent = (body.ChildNodes[39] as Paragraph).ParagraphFormat.LeftIndent;
    ```
