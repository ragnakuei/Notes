# bookmark 指定至超連結並更新 

> 注意：超連結文字不可有換行符號，否則會產生 Exception !

```cs
var doc = new Aspose.Words.Document(templateFile);

var bookmark = doc.Range.Bookmarks["bookmark01"];

if (bookmark != null)
{
    var currentNode = bookmark.BookmarkStart.NextSibling;

    while (currentNode != null)
    {
        FieldStart fieldStart = (FieldStart)currentNode;

        if (currentNode.NodeType == NodeType.FieldStart)
        {
            if (fieldStart.FieldType == FieldType.FieldHyperlink)
            {
                var hyperLink = (FieldHyperlink)fieldStart.GetField();
                hyperLink.Address = "https://tw.yahoo.com/";
                hyperLink.Result  = "...more";

                break; 
            }
        }

        // 如果还没有找到，则移动到下一个节点
        currentNode = currentNode.NextSibling;
    }
}
```